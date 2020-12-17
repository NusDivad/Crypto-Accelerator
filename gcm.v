`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2020 09:32:35 AM
// Design Name: 
// Module Name: gcm
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

//MODULARIZE

module gcm_forward(clk, key, plaintext, nonce, authdata, ciphertext, authtag);
   
    parameter numBlocks = 1;
    
    input clk;
    input [255:0] key;
    //input direction;
    input [128 * numBlocks - 1:0] plaintext;
    input [95:0] nonce;
    input [127:0] authdata;
    output [128 * numBlocks - 1:0] ciphertext;
    output [127:0] authtag;
    
    wire [1919:0] roundkeys;
    roundkey_gen generate_keys(clk, key, roundkeys);
    
    reg [255:0] last_key;
    //Revision starts here
    //STATE MACHINE QUALIFICATION
    reg [127:0] ctr;
    wire [127:0] encrypt_out;
    aes_encrypt single(clk, roundkeys, ctr, encrypt_out);
    

    reg [15:0] state = 0;
    reg [127:0] h, e0, e1;
    always @(posedge clk)
    begin
        if(last_key == key) begin state <= 0; end
        last_key = key;
        case(state)
            16'h0:
            begin
                ctr <= 128'b0;
                state <= 16'h1;
            end
            
            16'h1:
            begin
               ctr <= {nonce, 32'h1};
               state <= 16'h2; 
            end
            
            16'h2:
            begin
                ctr <= {nonce, 32'h2};
                state <= 16'h3;
            end
            
            16'h11:
            begin
                h <= encrypt_out;
                state <= 16'h12;
            end
            
            16'h12:
            begin
                e0 <= encrypt_out;
                state <= 16'h13;
            end
            
            16'h13:
            begin
                e1 <= encrypt_out;
                state <= 16'hFFFF;
            end
            
            16'hFFFF:
            begin
            end
            
            default:
            begin
                state <= state + 1;
            end
        endcase
    end
    //Revision ends here
//    wire [127:0] h;
//    aes_encrypt eh(clk, roundkeys, 128'b0, h);
    wire [128*(numBlocks + 1) - 1:0] eo;
    assign eo = {e1, e0};
    
//    genvar i0;
//    for(i0=0;i0<numBlocks+1;i0=i0+1)
//    begin
//        aes_encrypt encryption(clk, roundkeys, {nonce, 32'h00000001 + i0}, eo[(i0+1)*128 - 1 -: 128]);
//    end
    genvar i1;
    for(i1=1;i1<numBlocks+1;i1=i1+1)
    begin
        assign ciphertext[i1*128 - 1 -:  128] = plaintext[i1*128 - 1 -: 128] ^ eo[(i1+1)*128 - 1 -: 128];
    end
    
 //   wire [127:0] directional_input;
//    assign directional_input = {ciphertext, plaintext};
    wire [127:0] x1, x2, x3;
    multiply mult1(clk, h, authdata, x1);
    multiply mult2(clk, x1 ^ ciphertext[127:0], h, x2);
//    multiply mult2(clk, x1 ^ directional_input[direction * 128 - 1 -: 128], h, x2);
    multiply mult3(clk, h, 128'h80 ^ x2, x3);

    assign authtag = x3 ^ eo[127:0];
endmodule

module gcm_backward(clk, key, ciphertext, nonce, authdata, authtag, plaintext);
    
    parameter numBlocks = 1;
    input clk;
    input [255:0] key;
    input [128 * numBlocks - 1:0] ciphertext;
    input [95:0] nonce;
    input [127:0] authdata;
    output [127:0] authtag;
    output [128 * numBlocks - 1:0] plaintext;

    wire [1919:0] roundkeys;
    roundkey_gen generate_keys(clk, key, roundkeys);

    //Revision starts here
    //STATE MACHINE QUALIFICATION
    reg [127:0] ctr;
    wire [127:0] encrypt_out;
    aes_encrypt single(clk, roundkeys, ctr, encrypt_out);
    
    reg [255:0] last_key;

    reg [15:0] state = 0;
    reg [127:0] h, e0, e1;
    always @(posedge clk)
    begin
        if(last_key == key) begin state <= 0; end
        last_key = key;
        case(state)
            16'h0:
            begin
                ctr <= 128'b0;
                state <= 16'h1;
            end
            
            16'h1:
            begin
               ctr <= {nonce, 32'h1};
               state <= 16'h2; 
            end
            
            16'h2:
            begin
                ctr <= {nonce, 32'h2};
                state <= 16'h3;
            end
            
            16'h11:
            begin
                h <= encrypt_out;
                state <= 16'h12;
            end
            
            16'h12:
            begin
                e0 <= encrypt_out;
                state <= 16'h13;
            end
            
            16'h13:
            begin
                e1 <= encrypt_out;
                state <= 16'hFFFF;
            end
            
            16'hFFFF:
            begin
            end
            
            default:
            begin
                state <= state + 1;
            end
        endcase
    end
    //Revision ends here
    
//    wire [127:0] h;
//    aes_encrypt eh(clk, roundkeys, 128'b0, h);
    wire [128*(numBlocks + 1) - 1:0] eo;
    assign eo = {e1, e0};        
//    genvar i0;
//    for(i0=0;i0<numBlocks+1;i0=i0+1)
//    begin
//        aes_encrypt encryption(clk, roundkeys, {nonce, 32'h00000001 + i0}, eo[(i0+1)*128 - 1 -: 128]);
//    end
    genvar i1;
    for(i1=1;i1<numBlocks+1;i1=i1+1)
    begin
        assign plaintext[i1*128 - 1 -:  128] = ciphertext[i1*128 - 1 -: 128] ^ eo[(i1+1)*128 - 1 -: 128];
    end
    
    //GHASH - Parameterize
    wire [127:0] x1, x2, x3;
    multiply mult1(clk, h, authdata, x1);
    multiply mult2(clk, h, x1 ^ ciphertext[127:0], x2);
    multiply mult3(clk, h, 128'h80 ^ x2, x3);

    assign authtag = x3 ^ eo[127:0];

endmodule

module multiply(clk, x, y, out);
    input clk;
    input [127:0] x, y;
    output reg [127:0] out;
    
    integer count = 0;
    reg[127:0] z, z1, v, v1;
    
    always @(x, y) begin count <= 0; z <= 0; v <= y; end
    always @(posedge clk)
    begin
        if(count < 128)
        begin
            case(x[127 - count])
            1'b0: begin z1 = z; end
            1'b1: begin z1 = z ^ v; end
            endcase
            
            case(v[0])
            1'b0: begin v1 = v >> 1; end
            1'b1: begin v1 = (v >> 1) ^ 128'hE1000000000000000000000000000000; end
            endcase
            
            v = v1;
            z = z1;
            count = count + 1;
        end
        else begin out <= z; end
    end
endmodule