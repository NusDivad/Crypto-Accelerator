`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 09:55:31 AM
// Design Name: 
// Module Name: testbench
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

module gcm_test;
    reg clk;
    
    //MULTIPLY STARTS HERE
    reg [127:0] x = 0;
    reg [127:0] y = 0;
    wire [128 * 128 - 1:0] matrix;
    wire [127:0] out;
    
    matrix_gen mat_test(
    .clk(clk),
    .x(x),
    .out(matrix)
    );
    
    compute comp_test(
    .clk(clk),
    .y(y),
    .matrix(matrix),
    .out(out)
    );
    
    //GCM STARTS HERE
//    reg [127:0] plain = 0;
//    reg [95:0] nonce = 0;
//    reg [255:0] key;
//    reg [127:0] authdata = 0;
//    wire [127:0] cipher;
//    wire [127:0] authtag;
    
//    wire [127:0] authconfirm;
//    wire [127:0] out;
    
//    gcm_forward gcm_test(
//    .clk(clk),
//    .key(key),
//    .plaintext(plain),
//    .nonce(nonce),
//    .authdata(authdata),
//    .ciphertext(cipher),
//    .authtag(authtag)
//    );
    
//    gcm_backward gcm_back_test(
//    .clk(clk),
//    .key(key),
//    .ciphertext(cipher),
//    .nonce(nonce),
//    .authdata(authdata),
//    .authtag(authconfirm),
//    .plaintext(out)
//    );
    
    //GCM ENDS HERE

    //AES STARTS HERE
//    reg [255:0] key;
//    wire [1919:0] rk_out;
//    reg [127:0] plain;
//    wire [127:0] cipher;

//    roundkey_gen tester_roundkey (
//    .clk(clk),
//    .key(key),
//    .roundkeys(rk_out)
//    );
//    aes_encrypt tester_encryption(
//    .clk(clk),
//    .roundkeys(rk_out),
//    .plain(plain),
//    .out(cipher)
//    );
    
    //AES ENDS HERE
    
//    encrypt_round tester_round (
//    .clk(clk),
//    .in(message),
//    .key(key),
//    .out(encrypt_out)
//    );
//    aes_encrypt full_test(
//    .clk(clk),
//    .roundkeys(rk_in),
//    .plain(message),
//    .out(encrypt_out)
//    );
    
    initial begin
        clk = 0;
        
        #100
        x = 128'h10000000000000000000000000000000;
        y = 128'h1;
    end
    always
        #1 clk = !clk;
endmodule
