`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2020 08:49:27 AM
// Design Name: 
// Module Name: top_protocol
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_protocol(clk, reset, data_in, rdy_in, data_out, rdy_out, confirmed_read, to_proc_rdy, from_proc_rdy);
    input clk;
    input reset;
    input [127:0] data_in;
    input rdy_in;
    
    input confirmed_read;
    
    output reg to_proc_rdy, from_proc_rdy;
    
    output reg [127:0] data_out;
    output reg rdy_out;
    
    reg [95:0] nonce;
    reg [255:0] key = 255'h0;
    reg [127:0] plaintext_in, ciphertext_in;
    wire [127:0] plaintext_out, ciphertext_out;
    reg [127:0] authdata, authtag_check;
    wire [127:0] authtag, authconfirm;
    
    //TAKE A KEY
    
    //One encrypt one decrypt
    gcm_forward gcm_block(clk, key, plaintext_in, nonce, authdata, ciphertext_out, authtag);
    gcm_backward gcm_block2(clk, key, ciphertext_in, nonce, authdata, authconfirm, plaintext_out);
    reg [15:0] state;
    always @(posedge clk)
    begin
        if(~reset) state <= 16'b0;
        case(state)
            16'h0000:
            begin
                rdy_out <= 0;
                if(rdy_in)
                begin
                    case(data_in)
                        128'hFEDC000000001001: state <= 16'h1F01;
                        128'hFEDC000000000001: state <= 16'h0001;
                    endcase
                end
            end
            
            16'h1F01:
            begin
                if(~rdy_in) begin state <= 16'h1F02; end
            end
            
            16'h1F02:
            begin
                if(rdy_in) begin plaintext_in <= data_in; state <= 16'h1001; end
            end
            
            16'h0001:
            begin
                data_out <= 128'hFEDC000000001003;
                rdy_out <= 1;
                state <= 16'h0002;
            end
            
            16'h0002:
            begin
                if(confirmed_read) begin rdy_out <= 0; state <= 16'h0003; end
            end
            
            //Receiving data/info
            
            //Nonce
            16'h0003:
            begin
                //store data inside if
                if(rdy_in) begin nonce <= data_in[95:0]; state <= 16'h0004; end
            end
            
            16'h0004:
            begin
                if(~rdy_in) begin state <= 16'h0005; end
            end
            
            //Authdata
            16'h0005:
            begin
                //store data inside if
                if(rdy_in) begin authdata <= data_in; state <= 16'h0006; end
            end
            
            16'h0006:
            begin
                if(~rdy_in) begin state <= 16'h0007; end
            end
            
            //Authtag
            16'h0007:
            begin
                //store data inside if
                if(rdy_in) begin authtag_check <= data_in; state <= 16'h0008; end
            end
            
            16'h0008:
            begin
                if(~rdy_in) begin state <= 16'h0009; end
            end
            
            //Ciphertext
            16'h0009:
            begin
                //store data inside if
                if(rdy_in) begin ciphertext_in <= data_in; state <= 16'h000A; end
            end
            
            16'h000A:
            begin
                if(~rdy_in) begin state <= 16'h000B; end
            end
            //Decrypt
            
            
            16'h000B:
            begin
                //plaintext_out <= ciphertext_in ^ key[127:0];
                //authconfirm <= authdata ^ key[127:0];
                state <= 16'h0100;
            end
            
            16'h0200:
            begin
                data_out <= plaintext_out;
                to_proc_rdy <= 1;
                state <= 16'h000C;
            end
            
            //Terminate
            
            16'h000C:
            begin
                if(confirmed_read) begin to_proc_rdy <= 0; state <= 16'h0; end
            end
            
            
            //Write Cycle
            16'h1001:
            begin
                data_out <= 128'hFEDC000000000001;
                rdy_out <= 1;
                state <= 16'h1002;
            end
            
            16'h1002:
            begin
                if(confirmed_read) begin rdy_out <= 0; state <= 16'h1003; end
            end
            
            16'h1003:
            begin
                if(rdy_in)
                begin
                    case(data_in)
                        128'hFEDC000000001003:
                        begin
                            state <= 16'h1004;
                        end
                    endcase
                end
            end
            
            //Encrypt
            16'h1004:
            begin
                //ciphertext_out <= plaintext_in ^ key[127:0];
                //authtag <= authdata ^ key[127:0];
                state <= 16'h1100;
            end
            
            16'h1200:
            begin
                state <= 16'h1005;
            end
            
            //Writing data
            
            //Nonce
            16'h1005:
            begin
                rdy_out <= 1;
                data_out <= 96'h0;
                state <= 16'h1006;
            end
            
            16'h1006:
            begin
                if(confirmed_read) begin rdy_out <= 0; state <= 16'h1007; end
            end
            //Authdata
            16'h1007:
            begin
                rdy_out <= 1;
                data_out <= 128'h0;
                state <= 16'h1008;
            end
            
            16'h1008:
            begin
                if(confirmed_read) begin rdy_out <= 0; state <= 16'h1009; end
            end
            
            //Authtag
            16'h1009:
            begin
                rdy_out <= 1;
                data_out <= authtag;
                state <= 16'h100A;
            end
            
            16'h100A:
            begin
                if(confirmed_read) begin rdy_out <= 0; state <= 16'h100B; end
            end
            
            //Ciphertext
            16'h100B:
            begin
                rdy_out <= 1;
                data_out <= ciphertext_out;
                state <= 16'h100C;
            end
            
            16'h100C:
            begin
                if(confirmed_read) begin rdy_out <= 0; state <= 16'h100D; end
            end
            
            
            
            //Terminate
            16'h100D:
            begin
                state <= 16'h0000;
            end
            
            default: state <= state + 1;
        endcase
    end
    
endmodule
