`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TJHSST Microelectronics Lab
// Engineer: Jon Recta
// 
// Create Date: 09/26/2019 09:23:00 AM
// Design Name: 
// Module Name: root
// Project Name: crypto_accel
// Target Devices: Digileny Nexys A7 (XC7A100T-1SCSG324C)
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

module root(
    input CLK,
    input RESET,
    input [15:0] SW,
    inout [8:1] JA,
    input [8:1] JB,
    output [15:0] LED
    );
    
//    wire [255:0] key = 256'h0;
//    wire [127:0] plain = 256'h0;
//    wire [127:0] cipher;
//    wire [1919:0] rk;
//        roundkey_gen rk_test(CLK, key, rk);
//    aes_encrypt encrypt_test(CLK, rk, plain, cipher);
    
    wire[127:0] out;
    top_protocol to_synth(CLK, 1'b1, , , out , , , ,);
    
    //roundkey_gen rk_test(CLK, key, rk);
    //aes_encrypt encrypt_test(CLK, rk, plain, cipher);
    
    assign LED[1] = out[127];
    
endmodule