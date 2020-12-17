`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 08:57:29 AM
// Design Name: 
// Module Name: board
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

`include "AES.v"
module board_bi(
    input CLK,
    input Reset,
    input[15:0] SW,
    inout[8:1] JA,
    output[15:0] LED
    );
    reg[7:0] jaReg = 8'b0;
    reg[15:0] leds = 16'h0100;
    assign LED = leds;
    reg[3:0] state = 4'h0;
    reg write = 0;
    assign JA = (write) ? jaReg : 8'bz;
    reg[7:0] temp = 8'h00;
    
    integer i1;
    integer i2;
    reg[127:0] msg = 128'b0;
    reg[255:0] key = 256'b0;
    wire[127:0] out;
    aes_256 enc(CLK, msg, key, out);
    
    always @(posedge CLK, negedge Reset)
    begin
        if(~Reset) begin state <= 4'h0; leds <= 16'h0100; jaReg<= 8'b0; end
        else begin
            case(state)
                4'h0: begin
                    //for(i1=0; i1<127; i1=i1+8) msg[i1+7-:7] <= SW[7:0];
                    //for(i2=0; i2<255; i2=i2+8) key[i2+7-:7] <= SW[15:8];
                    msg[127:120] <= SW[7:0];
                    key[255:248] <= SW[15:8];
                    leds <= out[15:0];
                    end 
// Back and Forth
//                4'h0: begin
//                    if(JA == 8'hFF) begin state <= 4'h1; end 
//                    if(SW[0] == 1) begin state <= 4'h8; end
//                end
//                4'h1: begin
//                    jaReg = SW[7:0];
//                    write <= 1;
//                    state <= 4'h2;
//                end
//                4'h2: begin
//                    write <= 0;
//                    state <= 4'hF;
//                end
//                4'h8: begin
//                    jaReg <= 8'hFF;
//                    write <= 1;
//                    state <= 4'h9;
//                end
//                4'h9: begin
//                    write <= 0;
//                    state <= 4'hA;
//                end
//                4'hA: begin
//                    temp[7:0] <= JA[8:1];
//                    state <= 4'hB;
//                end
//                4'hB: begin
//                    leds[7:0] = temp ^ SW[7:0];
//                    state <= 4'hF;
//                end
//                4'hF: begin
//                   state <= 4'hF;
//                end 
                
            endcase
        end
    end
endmodule

module clock_div(
    input clk,
    input Reset,
    output wire slow_clk
    );
    reg[9:0] counter = 10'b0;
    assign slow_clk = counter[9];
    always @(posedge clk, negedge Reset)
    begin
        if(~Reset) begin counter <= 0; end 
        else begin 
            counter <= counter + 1;
            if(counter == 1023)
            begin
                counter <= 0;
            end
        end
    end
endmodule