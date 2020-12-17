`timescale 1ns / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2019 08:42:08 AM
// Design Name: 
// Module Name: AES
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
module aes_encrypt(clk, roundkeys, plain, out);
    input clk;
    input [1919:0] roundkeys;
    input [127:0] plain;
    output [127:0] out;
    
    wire[127:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14;
    assign {k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14} = roundkeys;
    wire[127:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13;
    reg[127:0] temp, first, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13;
    assign out = r13;
    
    encrypt_round
        e0(clk, first, k1, w0),
        e1(clk, r0, k2, w1),
        e2(clk, r1, k3, w2),
        e3(clk, r2, k4, w3),
        e4(clk, r3, k5, w4),
        e5(clk, r4, k6, w5),
        e6(clk, r5, k7, w6),
        e7(clk, r6, k8, w7),
        e8(clk, r7, k9, w8),
        e9(clk, r8, k10, w9),
        e10(clk, r9, k11, w10),
        e11(clk, r10, k12, w11),
        e12(clk, r11, k13, w12);
    encrypt_final_round e14(clk, r12, k14, w13);
        
        
    
    always @(posedge clk)
    begin
        temp <= plain;
        first <= temp ^ k0;
        r0 <= w0;
        r1 <= w1;
        r2 <= w2;
        r3 <= w3;
        r4 <= w4;
        r5 <= w5;
        r6 <= w6;
        r7 <= w7;
        r8 <= w8;
        r9 <= w9;
        r10 <= w10;
        r11 <= w11;
        r12 <= w12;
        r13 <= w13;
    end
endmodule

module encrypt_round(clk, in, key, out);
    input clk;
    input [127:0] in;
    input [127:0] key;
    output [127:0] out;
    
    wire[7:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15;
    assign {k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15} = key;
    wire[7:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15;
    assign {w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15} = in;
    wire[7:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15;
    wire[7:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15;
    wire[7:0] o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15;
    
    assign out = {o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15};
    sub
        sb0(clk, w0, s0),
        sb1(clk, w1, s1),
        sb2(clk, w2, s2),
        sb3(clk, w3, s3),
        sb4(clk, w4, s4),
        sb5(clk, w5, s5),
        sb6(clk, w6, s6),
        sb7(clk, w7, s7),
        sb8(clk, w8, s8),
        sb9(clk, w9, s9),
        sb10(clk, w10, s10),
        sb11(clk, w11, s11),
        sb12(clk, w12, s12),
        sb13(clk, w13, s13),
        sb14(clk, w14, s14),
        sb15(clk, w15, s15);
    tsub
        tsb0(clk, w0, t0),
        tsb1(clk, w1, t1),
        tsb2(clk, w2, t2),
        tsb3(clk, w3, t3),
        tsb4(clk, w4, t4),
        tsb5(clk, w5, t5),
        tsb6(clk, w6, t6),
        tsb7(clk, w7, t7),
        tsb8(clk, w8, t8),
        tsb9(clk, w9, t9),
        tsb10(clk, w10, t10),
        tsb11(clk, w11, t11),
        tsb12(clk, w12, t12),
        tsb13(clk, w13, t13),
        tsb14(clk, w14, t14),
        tsb15(clk, w15, t15);
assign o0 = t0 ^ s5 ^ t5 ^ s10 ^ s15 ^ k0;
assign o1 = s0 ^ t5 ^ s10 ^ t10 ^ s15 ^ k1;
assign o2 = s0 ^ s5 ^ t10 ^ s15 ^ t15 ^ k2;
assign o3 = s0 ^ t0 ^ s5 ^ s10 ^ t15 ^ k3;
        
assign o4 = t4 ^ s9 ^ t9 ^ s14 ^ s3 ^ k4;
assign o5 = s4 ^ t9 ^ s14 ^ t14 ^ s3 ^ k5;
assign o6 = s4 ^ s9 ^ t14 ^ s3 ^ t3 ^ k6;
assign o7 = s4 ^ t4 ^ s9 ^ s14 ^ t3 ^ k7;
       
assign o8 = t8 ^ s13 ^ t13 ^ s2 ^ s7 ^ k8;
assign o9 = s8 ^ t13 ^ s2 ^ t2 ^ s7 ^ k9;
assign o10 = s8 ^ s13 ^ t2 ^ s7 ^ t7 ^ k10;
assign o11 = s8 ^ t8 ^ s13 ^ s2 ^ t7 ^ k11;
       
assign o12 = t12 ^ s1 ^ t1 ^ s6 ^ s11 ^ k12;
assign o13 = s12 ^ t1 ^ s6 ^ t6 ^ s11 ^ k13;
assign o14 = s12 ^ s1 ^ t6 ^ s11 ^ t11 ^ k14;
assign o15 = s12 ^ t12 ^ s1 ^ s6 ^ t11 ^ k15;
//    always @(posedge clk)
//    begin
//        o0 <= t0 ^ s5 ^ t5 ^ s10 ^ s15 ^ k0;
//        o1 <= s0 ^ t5 ^ s10 ^ t10 ^ s15 ^ k1;
//        o2 <= s0 ^ s5 ^ t10 ^ s15 ^ t15 ^ k2;
//        o3 <= s0 ^ t0 ^ s5 ^ s10 ^ t15 ^ k3;
        
//        o4 <= t4 ^ s9 ^ t9 ^ s14 ^ s3 ^ k4;
//        o5 <= s4 ^ t9 ^ s14 ^ t14 ^ s3 ^ k5;
//        o6 <= s4 ^ s9 ^ t14 ^ s3 ^ t3 ^ k6;
//        o7 <= s4 ^ t4 ^ s9 ^ s14 ^ t3 ^ k7;
        
//        o8 <= t8 ^ s13 ^ t13 ^ s2 ^ s7 ^ k8;
//        o9 <= s8 ^ t13 ^ s2 ^ t2 ^ s7 ^ k9;
//        o10 <= s8 ^ s13 ^ t2 ^ s7 ^ t7 ^ k10;
//        o11 <= s8 ^ t8 ^ s13 ^ s2 ^ t7 ^ k11;
        
//        o12 <= t12 ^ s1 ^ t1 ^ s6 ^ s11 ^ k12;
//        o13 <= s12 ^ t1 ^ s6 ^ t6 ^ s11 ^ k13;
//        o14 <= s12 ^ s1 ^ t6 ^ s11 ^ t11 ^ k14;
//        o15 <= s12 ^ t12 ^ s1 ^ s6 ^ t11 ^ k15;
//    end
endmodule

module encrypt_final_round(clk, in, key, out);
    input clk;
    input [127:0] in;
    input [127:0] key;
    output [127:0] out;
    
    wire[7:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15;
    assign {k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15} = key;
    wire[7:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15;
    assign {w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15} = in;
    wire[7:0] s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15;
    wire[7:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15;
    wire[7:0] o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15;
    
    assign out = {o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15};
    sub
        sb0(clk, w0, s0),
        sb1(clk, w1, s1),
        sb2(clk, w2, s2),
        sb3(clk, w3, s3),
        sb4(clk, w4, s4),
        sb5(clk, w5, s5),
        sb6(clk, w6, s6),
        sb7(clk, w7, s7),
        sb8(clk, w8, s8),
        sb9(clk, w9, s9),
        sb10(clk, w10, s10),
        sb11(clk, w11, s11),
        sb12(clk, w12, s12),
        sb13(clk, w13, s13),
        sb14(clk, w14, s14),
        sb15(clk, w15, s15);
assign o0 = s0 ^ k0;
assign o1 = s5 ^ k1;
assign o2 = s10 ^ k2;
assign o3 = s15 ^ k3;
assign o4 = s4 ^ k4;
assign o5 = s9 ^ k5;
assign o6 = s14 ^ k6;
assign o7 = s3 ^ k7;
assign o8 = s8 ^ k8;
assign o9 = s13 ^ k9;
assign o10 = s2 ^ k10;
assign o11 = s7 ^ k11;
assign o12 = s12 ^ k12;
assign o13 = s1 ^ k13;
assign o14 = s6 ^ k14;
assign o15 = s11 ^ k15;
//    always @(posedge clk)
//    begin
//        o0 <= s0 ^ k0;
//        o1 <= s5 ^ k1;
//        o2 <= s10 ^ k2;
//        o3 <= s15 ^ k3;
//        o4 <= s4 ^ k4;
//        o5 <= s9 ^ k5;
//        o6 <= s14 ^ k6;
//        o7 <= s3 ^ k7;
//        o8 <= s8 ^ k8;
//        o9 <= s13 ^ k9;
//        o10 <= s2 ^ k10;
//        o11 <= s7 ^ k11;
//        o12 <= s12 ^ k12;
//        o13 <= s1 ^ k13;
//        o14 <= s6 ^ k14;
//        o15 <= s11 ^ k15;
//    end
endmodule

module roundkey_gen(clk, key, roundkeys);
    input clk;
    input [255:0] key;
    output wire[1919:0] roundkeys;
    wire[255:0] k0, k1, k2, k3, k4, k5, k6;
    wire[127:0] k7a;
    assign k0 = key;
    assign roundkeys = {k0, k1, k2, k3, k4, k5, k6, k7a};

    expand_key
        e1 (clk, k0, 32'h01000000, k1),
        e2 (clk, k1, 32'h02000000, k2),
        e3 (clk, k2, 32'h04000000, k3),
        e4 (clk, k3, 32'h08000000, k4),
        e5 (clk, k4, 32'h10000000, k5),
        e6 (clk, k5, 32'h20000000, k6);
     expand_key_final ekf1(clk, k6, 32'h40000000, k7a);
endmodule

module expand_key(clk, last_key, rcon, out);
    input clk;
    input [255:0] last_key;
    input [31:0] rcon;
    output [255:0] out;
    
    wire [31:0] l0, l1, l2, l3, l4, l5, l6, l7;
    wire [31:0] w0, w1, w2, w3, w4, w5, w6, w7;
    //    reg [31:0] w0, w1, w2, w3, w4, w5, w6, w7;    
    assign {l0, l1, l2, l3, l4, l5, l6, l7} = last_key;
    wire[31:0] t0, t1;
    sub4
        s0(clk, {l7[23:0], l7[31:24]}, t0),
        s4(clk, w3, t1);
//    always @(posedge clk)
//    begin
//        w0 <= t0 ^ l0 ^ rcon;
//        w1 <= t0 ^ l0 ^ rcon ^ l1;
//        w2 <= t0 ^ l0 ^ rcon ^ l1 ^ l2;
//        w3 <= t0 ^ l0 ^ rcon ^ l1 ^ l2 ^ l3;
//        w4 <= t1 ^ l4;
//        w5 <= t1 ^ l4 ^ l5;
//        w6 <= t1 ^ l4 ^ l5 ^ l6;
//        w7 <= t1 ^ l4 ^ l5 ^ l6 ^ l7;
//    end    
    
    assign w0 = t0 ^ l0 ^ rcon;
    assign w1 = t0 ^ l0 ^ rcon ^ l1;
    assign w2 = t0 ^ l0 ^ rcon ^ l1 ^ l2;
    assign w3 = t0 ^ l0 ^ rcon ^ l1 ^ l2 ^ l3;
    assign w4 = t1 ^ l4;
    assign w5 = t1 ^ l4 ^ l5;
    assign w6 = t1 ^ l4 ^ l5 ^ l6;
    assign w7 = t1 ^ l4 ^ l5 ^ l6 ^ l7;
    
    assign out = {w0, w1, w2, w3, w4, w5, w6, w7};
endmodule

module expand_key_final(clk, last_key, rcon, out);
    input clk;
    input [255:0] last_key;
    input [31:0] rcon;
    output [127:0] out;
    
    wire [31:0] l0, l1, l2, l3, l4, l5, l6, l7;
    wire [31:0] w0, w1, w2, w3;
    assign {l0, l1, l2, l3, l4, l5, l6, l7} = last_key[255:0];
    
    wire[31:0] t0;
    sub4 s4(clk, {l7[23:0], l7[31:24]}, t0);
    assign w0 = t0 ^ l0 ^ rcon;
    assign w1 = t0 ^ l0 ^ rcon ^ l1;
    assign w2 = t0 ^ l0 ^ rcon ^ l1 ^ l2;
    assign w3 = t0 ^ l0 ^ rcon ^ l1 ^ l2 ^ l3;
    
    assign out = {w0, w1, w2, w3};
endmodule

module sub4(clk, in, out);
    input clk;
    input [31:0] in;
    output [31:0] out;
    
    sub
        s0(clk, in[7:0], out[7:0]),
        s1(clk, in[15:8], out[15:8]),
        s2(clk, in[23:16], out[23:16]),
        s3(clk, in[31:24], out[31:24]);
 endmodule
 
module sub(clk, in, out);
    input clk;
    input [7:0] in;
    output reg [7:0] out;
    always @(negedge clk)
        case(in)
        8'h00: out <= 8'h63;
        8'h01: out <= 8'h7c;
        8'h02: out <= 8'h77;
        8'h03: out <= 8'h7b;
        8'h04: out <= 8'hf2;
        8'h05: out <= 8'h6b;
        8'h06: out <= 8'h6f;
        8'h07: out <= 8'hc5;
        8'h08: out <= 8'h30;
        8'h09: out <= 8'h01;
        8'h0a: out <= 8'h67;
        8'h0b: out <= 8'h2b;
        8'h0c: out <= 8'hfe;
        8'h0d: out <= 8'hd7;
        8'h0e: out <= 8'hab;
        8'h0f: out <= 8'h76;
        8'h10: out <= 8'hca;
        8'h11: out <= 8'h82;
        8'h12: out <= 8'hc9;
        8'h13: out <= 8'h7d;
        8'h14: out <= 8'hfa;
        8'h15: out <= 8'h59;
        8'h16: out <= 8'h47;
        8'h17: out <= 8'hf0;
        8'h18: out <= 8'had;
        8'h19: out <= 8'hd4;
        8'h1a: out <= 8'ha2;
        8'h1b: out <= 8'haf;
        8'h1c: out <= 8'h9c;
        8'h1d: out <= 8'ha4;
        8'h1e: out <= 8'h72;
        8'h1f: out <= 8'hc0;
        8'h20: out <= 8'hb7;
        8'h21: out <= 8'hfd;
        8'h22: out <= 8'h93;
        8'h23: out <= 8'h26;
        8'h24: out <= 8'h36;
        8'h25: out <= 8'h3f;
        8'h26: out <= 8'hf7;
        8'h27: out <= 8'hcc;
        8'h28: out <= 8'h34;
        8'h29: out <= 8'ha5;
        8'h2a: out <= 8'he5;
        8'h2b: out <= 8'hf1;
        8'h2c: out <= 8'h71;
        8'h2d: out <= 8'hd8;
        8'h2e: out <= 8'h31;
        8'h2f: out <= 8'h15;
        8'h30: out <= 8'h04;
        8'h31: out <= 8'hc7;
        8'h32: out <= 8'h23;
        8'h33: out <= 8'hc3;
        8'h34: out <= 8'h18;
        8'h35: out <= 8'h96;
        8'h36: out <= 8'h05;
        8'h37: out <= 8'h9a;
        8'h38: out <= 8'h07;
        8'h39: out <= 8'h12;
        8'h3a: out <= 8'h80;
        8'h3b: out <= 8'he2;
        8'h3c: out <= 8'heb;
        8'h3d: out <= 8'h27;
        8'h3e: out <= 8'hb2;
        8'h3f: out <= 8'h75;
        8'h40: out <= 8'h09;
        8'h41: out <= 8'h83;
        8'h42: out <= 8'h2c;
        8'h43: out <= 8'h1a;
        8'h44: out <= 8'h1b;
        8'h45: out <= 8'h6e;
        8'h46: out <= 8'h5a;
        8'h47: out <= 8'ha0;
        8'h48: out <= 8'h52;
        8'h49: out <= 8'h3b;
        8'h4a: out <= 8'hd6;
        8'h4b: out <= 8'hb3;
        8'h4c: out <= 8'h29;
        8'h4d: out <= 8'he3;
        8'h4e: out <= 8'h2f;
        8'h4f: out <= 8'h84;
        8'h50: out <= 8'h53;
        8'h51: out <= 8'hd1;
        8'h52: out <= 8'h00;
        8'h53: out <= 8'hed;
        8'h54: out <= 8'h20;
        8'h55: out <= 8'hfc;
        8'h56: out <= 8'hb1;
        8'h57: out <= 8'h5b;
        8'h58: out <= 8'h6a;
        8'h59: out <= 8'hcb;
        8'h5a: out <= 8'hbe;
        8'h5b: out <= 8'h39;
        8'h5c: out <= 8'h4a;
        8'h5d: out <= 8'h4c;
        8'h5e: out <= 8'h58;
        8'h5f: out <= 8'hcf;
        8'h60: out <= 8'hd0;
        8'h61: out <= 8'hef;
        8'h62: out <= 8'haa;
        8'h63: out <= 8'hfb;
        8'h64: out <= 8'h43;
        8'h65: out <= 8'h4d;
        8'h66: out <= 8'h33;
        8'h67: out <= 8'h85;
        8'h68: out <= 8'h45;
        8'h69: out <= 8'hf9;
        8'h6a: out <= 8'h02;
        8'h6b: out <= 8'h7f;
        8'h6c: out <= 8'h50;
        8'h6d: out <= 8'h3c;
        8'h6e: out <= 8'h9f;
        8'h6f: out <= 8'ha8;
        8'h70: out <= 8'h51;
        8'h71: out <= 8'ha3;
        8'h72: out <= 8'h40;
        8'h73: out <= 8'h8f;
        8'h74: out <= 8'h92;
        8'h75: out <= 8'h9d;
        8'h76: out <= 8'h38;
        8'h77: out <= 8'hf5;
        8'h78: out <= 8'hbc;
        8'h79: out <= 8'hb6;
        8'h7a: out <= 8'hda;
        8'h7b: out <= 8'h21;
        8'h7c: out <= 8'h10;
        8'h7d: out <= 8'hff;
        8'h7e: out <= 8'hf3;
        8'h7f: out <= 8'hd2;
        8'h80: out <= 8'hcd;
        8'h81: out <= 8'h0c;
        8'h82: out <= 8'h13;
        8'h83: out <= 8'hec;
        8'h84: out <= 8'h5f;
        8'h85: out <= 8'h97;
        8'h86: out <= 8'h44;
        8'h87: out <= 8'h17;
        8'h88: out <= 8'hc4;
        8'h89: out <= 8'ha7;
        8'h8a: out <= 8'h7e;
        8'h8b: out <= 8'h3d;
        8'h8c: out <= 8'h64;
        8'h8d: out <= 8'h5d;
        8'h8e: out <= 8'h19;
        8'h8f: out <= 8'h73;
        8'h90: out <= 8'h60;
        8'h91: out <= 8'h81;
        8'h92: out <= 8'h4f;
        8'h93: out <= 8'hdc;
        8'h94: out <= 8'h22;
        8'h95: out <= 8'h2a;
        8'h96: out <= 8'h90;
        8'h97: out <= 8'h88;
        8'h98: out <= 8'h46;
        8'h99: out <= 8'hee;
        8'h9a: out <= 8'hb8;
        8'h9b: out <= 8'h14;
        8'h9c: out <= 8'hde;
        8'h9d: out <= 8'h5e;
        8'h9e: out <= 8'h0b;
        8'h9f: out <= 8'hdb;
        8'ha0: out <= 8'he0;
        8'ha1: out <= 8'h32;
        8'ha2: out <= 8'h3a;
        8'ha3: out <= 8'h0a;
        8'ha4: out <= 8'h49;
        8'ha5: out <= 8'h06;
        8'ha6: out <= 8'h24;
        8'ha7: out <= 8'h5c;
        8'ha8: out <= 8'hc2;
        8'ha9: out <= 8'hd3;
        8'haa: out <= 8'hac;
        8'hab: out <= 8'h62;
        8'hac: out <= 8'h91;
        8'had: out <= 8'h95;
        8'hae: out <= 8'he4;
        8'haf: out <= 8'h79;
        8'hb0: out <= 8'he7;
        8'hb1: out <= 8'hc8;
        8'hb2: out <= 8'h37;
        8'hb3: out <= 8'h6d;
        8'hb4: out <= 8'h8d;
        8'hb5: out <= 8'hd5;
        8'hb6: out <= 8'h4e;
        8'hb7: out <= 8'ha9;
        8'hb8: out <= 8'h6c;
        8'hb9: out <= 8'h56;
        8'hba: out <= 8'hf4;
        8'hbb: out <= 8'hea;
        8'hbc: out <= 8'h65;
        8'hbd: out <= 8'h7a;
        8'hbe: out <= 8'hae;
        8'hbf: out <= 8'h08;
        8'hc0: out <= 8'hba;
        8'hc1: out <= 8'h78;
        8'hc2: out <= 8'h25;
        8'hc3: out <= 8'h2e;
        8'hc4: out <= 8'h1c;
        8'hc5: out <= 8'ha6;
        8'hc6: out <= 8'hb4;
        8'hc7: out <= 8'hc6;
        8'hc8: out <= 8'he8;
        8'hc9: out <= 8'hdd;
        8'hca: out <= 8'h74;
        8'hcb: out <= 8'h1f;
        8'hcc: out <= 8'h4b;
        8'hcd: out <= 8'hbd;
        8'hce: out <= 8'h8b;
        8'hcf: out <= 8'h8a;
        8'hd0: out <= 8'h70;
        8'hd1: out <= 8'h3e;
        8'hd2: out <= 8'hb5;
        8'hd3: out <= 8'h66;
        8'hd4: out <= 8'h48;
        8'hd5: out <= 8'h03;
        8'hd6: out <= 8'hf6;
        8'hd7: out <= 8'h0e;
        8'hd8: out <= 8'h61;
        8'hd9: out <= 8'h35;
        8'hda: out <= 8'h57;
        8'hdb: out <= 8'hb9;
        8'hdc: out <= 8'h86;
        8'hdd: out <= 8'hc1;
        8'hde: out <= 8'h1d;
        8'hdf: out <= 8'h9e;
        8'he0: out <= 8'he1;
        8'he1: out <= 8'hf8;
        8'he2: out <= 8'h98;
        8'he3: out <= 8'h11;
        8'he4: out <= 8'h69;
        8'he5: out <= 8'hd9;
        8'he6: out <= 8'h8e;
        8'he7: out <= 8'h94;
        8'he8: out <= 8'h9b;
        8'he9: out <= 8'h1e;
        8'hea: out <= 8'h87;
        8'heb: out <= 8'he9;
        8'hec: out <= 8'hce;
        8'hed: out <= 8'h55;
        8'hee: out <= 8'h28;
        8'hef: out <= 8'hdf;
        8'hf0: out <= 8'h8c;
        8'hf1: out <= 8'ha1;
        8'hf2: out <= 8'h89;
        8'hf3: out <= 8'h0d;
        8'hf4: out <= 8'hbf;
        8'hf5: out <= 8'he6;
        8'hf6: out <= 8'h42;
        8'hf7: out <= 8'h68;
        8'hf8: out <= 8'h41;
        8'hf9: out <= 8'h99;
        8'hfa: out <= 8'h2d;
        8'hfb: out <= 8'h0f;
        8'hfc: out <= 8'hb0;
        8'hfd: out <= 8'h54;
        8'hfe: out <= 8'hbb;
        8'hff: out <= 8'h16;
        endcase 
endmodule

module tsub(clk, in, out);
    input clk;
    input [7:0] in;
    output reg [7:0] out;
    always @(negedge clk)
        case(in)
        8'h00: out <= 8'hc6;
        8'h01: out <= 8'hf8;
        8'h02: out <= 8'hee;
        8'h03: out <= 8'hf6;
        8'h04: out <= 8'hff;
        8'h05: out <= 8'hd6;
        8'h06: out <= 8'hde;
        8'h07: out <= 8'h91;
        8'h08: out <= 8'h60;
        8'h09: out <= 8'h02;
        8'h0a: out <= 8'hce;
        8'h0b: out <= 8'h56;
        8'h0c: out <= 8'he7;
        8'h0d: out <= 8'hb5;
        8'h0e: out <= 8'h4d;
        8'h0f: out <= 8'hec;
        8'h10: out <= 8'h8f;
        8'h11: out <= 8'h1f;
        8'h12: out <= 8'h89;
        8'h13: out <= 8'hfa;
        8'h14: out <= 8'hef;
        8'h15: out <= 8'hb2;
        8'h16: out <= 8'h8e;
        8'h17: out <= 8'hfb;
        8'h18: out <= 8'h41;
        8'h19: out <= 8'hb3;
        8'h1a: out <= 8'h5f;
        8'h1b: out <= 8'h45;
        8'h1c: out <= 8'h23;
        8'h1d: out <= 8'h53;
        8'h1e: out <= 8'he4;
        8'h1f: out <= 8'h9b;
        8'h20: out <= 8'h75;
        8'h21: out <= 8'he1;
        8'h22: out <= 8'h3d;
        8'h23: out <= 8'h4c;
        8'h24: out <= 8'h6c;
        8'h25: out <= 8'h7e;
        8'h26: out <= 8'hf5;
        8'h27: out <= 8'h83;
        8'h28: out <= 8'h68;
        8'h29: out <= 8'h51;
        8'h2a: out <= 8'hd1;
        8'h2b: out <= 8'hf9;
        8'h2c: out <= 8'he2;
        8'h2d: out <= 8'hab;
        8'h2e: out <= 8'h62;
        8'h2f: out <= 8'h2a;
        8'h30: out <= 8'h08;
        8'h31: out <= 8'h95;
        8'h32: out <= 8'h46;
        8'h33: out <= 8'h9d;
        8'h34: out <= 8'h30;
        8'h35: out <= 8'h37;
        8'h36: out <= 8'h0a;
        8'h37: out <= 8'h2f;
        8'h38: out <= 8'h0e;
        8'h39: out <= 8'h24;
        8'h3a: out <= 8'h1b;
        8'h3b: out <= 8'hdf;
        8'h3c: out <= 8'hcd;
        8'h3d: out <= 8'h4e;
        8'h3e: out <= 8'h7f;
        8'h3f: out <= 8'hea;
        8'h40: out <= 8'h12;
        8'h41: out <= 8'h1d;
        8'h42: out <= 8'h58;
        8'h43: out <= 8'h34;
        8'h44: out <= 8'h36;
        8'h45: out <= 8'hdc;
        8'h46: out <= 8'hb4;
        8'h47: out <= 8'h5b;
        8'h48: out <= 8'ha4;
        8'h49: out <= 8'h76;
        8'h4a: out <= 8'hb7;
        8'h4b: out <= 8'h7d;
        8'h4c: out <= 8'h52;
        8'h4d: out <= 8'hdd;
        8'h4e: out <= 8'h5e;
        8'h4f: out <= 8'h13;
        8'h50: out <= 8'ha6;
        8'h51: out <= 8'hb9;
        8'h52: out <= 8'h00;
        8'h53: out <= 8'hc1;
        8'h54: out <= 8'h40;
        8'h55: out <= 8'he3;
        8'h56: out <= 8'h79;
        8'h57: out <= 8'hb6;
        8'h58: out <= 8'hd4;
        8'h59: out <= 8'h8d;
        8'h5a: out <= 8'h67;
        8'h5b: out <= 8'h72;
        8'h5c: out <= 8'h94;
        8'h5d: out <= 8'h98;
        8'h5e: out <= 8'hb0;
        8'h5f: out <= 8'h85;
        8'h60: out <= 8'hbb;
        8'h61: out <= 8'hc5;
        8'h62: out <= 8'h4f;
        8'h63: out <= 8'hed;
        8'h64: out <= 8'h86;
        8'h65: out <= 8'h9a;
        8'h66: out <= 8'h66;
        8'h67: out <= 8'h11;
        8'h68: out <= 8'h8a;
        8'h69: out <= 8'he9;
        8'h6a: out <= 8'h04;
        8'h6b: out <= 8'hfe;
        8'h6c: out <= 8'ha0;
        8'h6d: out <= 8'h78;
        8'h6e: out <= 8'h25;
        8'h6f: out <= 8'h4b;
        8'h70: out <= 8'ha2;
        8'h71: out <= 8'h5d;
        8'h72: out <= 8'h80;
        8'h73: out <= 8'h05;
        8'h74: out <= 8'h3f;
        8'h75: out <= 8'h21;
        8'h76: out <= 8'h70;
        8'h77: out <= 8'hf1;
        8'h78: out <= 8'h63;
        8'h79: out <= 8'h77;
        8'h7a: out <= 8'haf;
        8'h7b: out <= 8'h42;
        8'h7c: out <= 8'h20;
        8'h7d: out <= 8'he5;
        8'h7e: out <= 8'hfd;
        8'h7f: out <= 8'hbf;
        8'h80: out <= 8'h81;
        8'h81: out <= 8'h18;
        8'h82: out <= 8'h26;
        8'h83: out <= 8'hc3;
        8'h84: out <= 8'hbe;
        8'h85: out <= 8'h35;
        8'h86: out <= 8'h88;
        8'h87: out <= 8'h2e;
        8'h88: out <= 8'h93;
        8'h89: out <= 8'h55;
        8'h8a: out <= 8'hfc;
        8'h8b: out <= 8'h7a;
        8'h8c: out <= 8'hc8;
        8'h8d: out <= 8'hba;
        8'h8e: out <= 8'h32;
        8'h8f: out <= 8'he6;
        8'h90: out <= 8'hc0;
        8'h91: out <= 8'h19;
        8'h92: out <= 8'h9e;
        8'h93: out <= 8'ha3;
        8'h94: out <= 8'h44;
        8'h95: out <= 8'h54;
        8'h96: out <= 8'h3b;
        8'h97: out <= 8'h0b;
        8'h98: out <= 8'h8c;
        8'h99: out <= 8'hc7;
        8'h9a: out <= 8'h6b;
        8'h9b: out <= 8'h28;
        8'h9c: out <= 8'ha7;
        8'h9d: out <= 8'hbc;
        8'h9e: out <= 8'h16;
        8'h9f: out <= 8'had;
        8'ha0: out <= 8'hdb;
        8'ha1: out <= 8'h64;
        8'ha2: out <= 8'h74;
        8'ha3: out <= 8'h14;
        8'ha4: out <= 8'h92;
        8'ha5: out <= 8'h0c;
        8'ha6: out <= 8'h48;
        8'ha7: out <= 8'hb8;
        8'ha8: out <= 8'h9f;
        8'ha9: out <= 8'hbd;
        8'haa: out <= 8'h43;
        8'hab: out <= 8'hc4;
        8'hac: out <= 8'h39;
        8'had: out <= 8'h31;
        8'hae: out <= 8'hd3;
        8'haf: out <= 8'hf2;
        8'hb0: out <= 8'hd5;
        8'hb1: out <= 8'h8b;
        8'hb2: out <= 8'h6e;
        8'hb3: out <= 8'hda;
        8'hb4: out <= 8'h01;
        8'hb5: out <= 8'hb1;
        8'hb6: out <= 8'h9c;
        8'hb7: out <= 8'h49;
        8'hb8: out <= 8'hd8;
        8'hb9: out <= 8'hac;
        8'hba: out <= 8'hf3;
        8'hbb: out <= 8'hcf;
        8'hbc: out <= 8'hca;
        8'hbd: out <= 8'hf4;
        8'hbe: out <= 8'h47;
        8'hbf: out <= 8'h10;
        8'hc0: out <= 8'h6f;
        8'hc1: out <= 8'hf0;
        8'hc2: out <= 8'h4a;
        8'hc3: out <= 8'h5c;
        8'hc4: out <= 8'h38;
        8'hc5: out <= 8'h57;
        8'hc6: out <= 8'h73;
        8'hc7: out <= 8'h97;
        8'hc8: out <= 8'hcb;
        8'hc9: out <= 8'ha1;
        8'hca: out <= 8'he8;
        8'hcb: out <= 8'h3e;
        8'hcc: out <= 8'h96;
        8'hcd: out <= 8'h61;
        8'hce: out <= 8'h0d;
        8'hcf: out <= 8'h0f;
        8'hd0: out <= 8'he0;
        8'hd1: out <= 8'h7c;
        8'hd2: out <= 8'h71;
        8'hd3: out <= 8'hcc;
        8'hd4: out <= 8'h90;
        8'hd5: out <= 8'h06;
        8'hd6: out <= 8'hf7;
        8'hd7: out <= 8'h1c;
        8'hd8: out <= 8'hc2;
        8'hd9: out <= 8'h6a;
        8'hda: out <= 8'hae;
        8'hdb: out <= 8'h69;
        8'hdc: out <= 8'h17;
        8'hdd: out <= 8'h99;
        8'hde: out <= 8'h3a;
        8'hdf: out <= 8'h27;
        8'he0: out <= 8'hd9;
        8'he1: out <= 8'heb;
        8'he2: out <= 8'h2b;
        8'he3: out <= 8'h22;
        8'he4: out <= 8'hd2;
        8'he5: out <= 8'ha9;
        8'he6: out <= 8'h07;
        8'he7: out <= 8'h33;
        8'he8: out <= 8'h2d;
        8'he9: out <= 8'h3c;
        8'hea: out <= 8'h15;
        8'heb: out <= 8'hc9;
        8'hec: out <= 8'h87;
        8'hed: out <= 8'haa;
        8'hee: out <= 8'h50;
        8'hef: out <= 8'ha5;
        8'hf0: out <= 8'h03;
        8'hf1: out <= 8'h59;
        8'hf2: out <= 8'h09;
        8'hf3: out <= 8'h1a;
        8'hf4: out <= 8'h65;
        8'hf5: out <= 8'hd7;
        8'hf6: out <= 8'h84;
        8'hf7: out <= 8'hd0;
        8'hf8: out <= 8'h82;
        8'hf9: out <= 8'h29;
        8'hfa: out <= 8'h5a;
        8'hfb: out <= 8'h1e;
        8'hfc: out <= 8'h7b;
        8'hfd: out <= 8'ha8;
        8'hfe: out <= 8'h6d;
        8'hff: out <= 8'h2c;
        endcase
endmodule