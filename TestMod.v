`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 08:59:03 AM
// Design Name: 
// Module Name: 
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



module newRead(clk, msg, out);
    input clk;
    input [7:0] msg;
    output reg out;
    reg [27:0] index = 28'b0;
    always @ (posedge clk)
        begin
            if(out == 1)
            begin
                index = index + 1;
                if(index == 268435455)
                begin
                    out = ~out;
                    index = 0;
                end
            end
            if(out == 0)
            begin
                if(msg == 8'b00000000)
                begin
                    out = ~out;
                end
            end
        end
endmodule


module splitter(clk, msg, out);
    input clk;
    input [15:0] msg;
    output reg [7:0] out;
    reg number = 0;
    always @ (posedge clk)
        begin
            if(number == 0)
                begin out <= msg[7:0]; end
            if(number == 1)
                begin out <= msg[15:8]; end
            number = ~number;
        end
endmodule