`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2020 11:39:00 PM
// Design Name: 
// Module Name: test
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

module matrix_gen(clk, x, out);
    input clk;
    input [127:0] x;
    output reg [128 * 128 - 1:0] out;
    
    integer count = 0;
    reg [127:0] z, z1;
    always @(x) begin count <= 0; z <= x; end
    always @(posedge clk)
    begin
        if(count < 128)
        begin
            case(z[0])
            1'b0: begin z1 = z >> 1; end
            1'b1: begin z1 = (z >> 1) ^ 128'hE1000000000000000000000000000000; end
            endcase
            z = z1;
            count = count + 1;
            out[count * 128 - 1 -: 128] = z;
        end
    end
endmodule

module compute(clk, matrix, y, out);
    input clk;
    input [128 * 128 - 1:0] matrix;
    input [127:0] y;
    output reg [127:0] out;
    
    integer i;
    always @(posedge clk)
    begin
        for(i = 0; i < 128; i = i + 1)
        begin
            out[i] <= (matrix[0+i]&y[127])^(matrix[128+i]&y[126])^(matrix[256+i]&y[125])^(matrix[384+i]&y[124])^(matrix[512+i]&y[123])^(matrix[640+i]&y[122])^(matrix[768+i]&y[121])^(matrix[896+i]&y[120])^(matrix[1024+i]&y[119])^(matrix[1152+i]&y[118])^(matrix[1280+i]&y[117])^(matrix[1408+i]&y[116])^(matrix[1536+i]&y[115])^(matrix[1664+i]&y[114])^(matrix[1792+i]&y[113])^(matrix[1920+i]&y[112])^(matrix[2048+i]&y[111])^(matrix[2176+i]&y[110])^(matrix[2304+i]&y[109])^(matrix[2432+i]&y[108])^(matrix[2560+i]&y[107])^(matrix[2688+i]&y[106])^(matrix[2816+i]&y[105])^(matrix[2944+i]&y[104])^(matrix[3072+i]&y[103])^(matrix[3200+i]&y[102])^(matrix[3328+i]&y[101])^(matrix[3456+i]&y[100])^(matrix[3584+i]&y[99])^(matrix[3712+i]&y[98])^(matrix[3840+i]&y[97])^(matrix[3968+i]&y[96])^(matrix[4096+i]&y[95])^(matrix[4224+i]&y[94])^(matrix[4352+i]&y[93])^(matrix[4480+i]&y[92])^(matrix[4608+i]&y[91])^(matrix[4736+i]&y[90])^(matrix[4864+i]&y[89])^(matrix[4992+i]&y[88])^(matrix[5120+i]&y[87])^(matrix[5248+i]&y[86])^(matrix[5376+i]&y[85])^(matrix[5504+i]&y[84])^(matrix[5632+i]&y[83])^(matrix[5760+i]&y[82])^(matrix[5888+i]&y[81])^(matrix[6016+i]&y[80])^(matrix[6144+i]&y[79])^(matrix[6272+i]&y[78])^(matrix[6400+i]&y[77])^(matrix[6528+i]&y[76])^(matrix[6656+i]&y[75])^(matrix[6784+i]&y[74])^(matrix[6912+i]&y[73])^(matrix[7040+i]&y[72])^(matrix[7168+i]&y[71])^(matrix[7296+i]&y[70])^(matrix[7424+i]&y[69])^(matrix[7552+i]&y[68])^(matrix[7680+i]&y[67])^(matrix[7808+i]&y[66])^(matrix[7936+i]&y[65])^(matrix[8064+i]&y[64])^(matrix[8192+i]&y[63])^(matrix[8320+i]&y[62])^(matrix[8448+i]&y[61])^(matrix[8576+i]&y[60])^(matrix[8704+i]&y[59])^(matrix[8832+i]&y[58])^(matrix[8960+i]&y[57])^(matrix[9088+i]&y[56])^(matrix[9216+i]&y[55])^(matrix[9344+i]&y[54])^(matrix[9472+i]&y[53])^(matrix[9600+i]&y[52])^(matrix[9728+i]&y[51])^(matrix[9856+i]&y[50])^(matrix[9984+i]&y[49])^(matrix[10112+i]&y[48])^(matrix[10240+i]&y[47])^(matrix[10368+i]&y[46])^(matrix[10496+i]&y[45])^(matrix[10624+i]&y[44])^(matrix[10752+i]&y[43])^(matrix[10880+i]&y[42])^(matrix[11008+i]&y[41])^(matrix[11136+i]&y[40])^(matrix[11264+i]&y[39])^(matrix[11392+i]&y[38])^(matrix[11520+i]&y[37])^(matrix[11648+i]&y[36])^(matrix[11776+i]&y[35])^(matrix[11904+i]&y[34])^(matrix[12032+i]&y[33])^(matrix[12160+i]&y[32])^(matrix[12288+i]&y[31])^(matrix[12416+i]&y[30])^(matrix[12544+i]&y[29])^(matrix[12672+i]&y[28])^(matrix[12800+i]&y[27])^(matrix[12928+i]&y[26])^(matrix[13056+i]&y[25])^(matrix[13184+i]&y[24])^(matrix[13312+i]&y[23])^(matrix[13440+i]&y[22])^(matrix[13568+i]&y[21])^(matrix[13696+i]&y[20])^(matrix[13824+i]&y[19])^(matrix[13952+i]&y[18])^(matrix[14080+i]&y[17])^(matrix[14208+i]&y[16])^(matrix[14336+i]&y[15])^(matrix[14464+i]&y[14])^(matrix[14592+i]&y[13])^(matrix[14720+i]&y[12])^(matrix[14848+i]&y[11])^(matrix[14976+i]&y[10])^(matrix[15104+i]&y[9])^(matrix[15232+i]&y[8])^(matrix[15360+i]&y[7])^(matrix[15488+i]&y[6])^(matrix[15616+i]&y[5])^(matrix[15744+i]&y[4])^(matrix[15872+i]&y[3])^(matrix[16000+i]&y[2])^(matrix[16128+i]&y[1])^(matrix[16256+i]&y[0]);
        end
    end
 
endmodule