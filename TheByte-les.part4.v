//=================================================================
//
// D Flip Flop
//
//=================================================================
module DFF(clk,in,out);
	input          clk;
	input   in;
	output  out;
	reg     out;

	always @(posedge clk)
	out = in;
endmodule

//=================================================================
//
// DECODER
//
//=================================================================
module Dec(binary,DecToMux);

	input [3:0] binary;
	output [15:0]DecToMux;
	
	assign DecToMux[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign DecToMux[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
	assign DecToMux[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
	assign DecToMux[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
	assign DecToMux[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
	assign DecToMux[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
	assign DecToMux[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
	assign DecToMux[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
	assign DecToMux[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign DecToMux[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
	assign DecToMux[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
	assign DecToMux[11]= binary[3]&~binary[2]& binary[1]& binary[0];
	assign DecToMux[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
	assign DecToMux[13]= binary[3]& binary[2]&~binary[1]& binary[0];
	assign DecToMux[14]= binary[3]& binary[2]& binary[1]&~binary[0];
	assign DecToMux[15]= binary[3]& binary[2]& binary[1]& binary[0];
	
endmodule

//=================================================================
//
// 32-bit, 16 channel Multiplexer
//
//=================================================================

module Mux(channels, DecToMux, b);
input	[15:0][31:0]	channels;
input	[15:0] 			DecToMux;
output	[31:0] 			b;

	assign b = ({32{DecToMux[15]}} & channels[15]) | 
               ({32{DecToMux[14]}} & channels[14]) |
			   ({32{DecToMux[13]}} & channels[13]) |
			   ({32{DecToMux[12]}} & channels[12]) |
			   ({32{DecToMux[11]}} & channels[11]) |
			   ({32{DecToMux[10]}} & channels[10]) |
			   ({32{DecToMux[ 9]}} & channels[ 9]) | 
			   ({32{DecToMux[ 8]}} & channels[ 8]) |
			   ({32{DecToMux[ 7]}} & channels[ 7]) |
			   ({32{DecToMux[ 6]}} & channels[ 6]) |
			   ({32{DecToMux[ 5]}} & channels[ 5]) |  
			   ({32{DecToMux[ 4]}} & channels[ 4]) |  
			   ({32{DecToMux[ 3]}} & channels[ 3]) |  
			   ({32{DecToMux[ 2]}} & channels[ 2]) |  
               ({32{DecToMux[ 1]}} & channels[ 1]) |  
               ({32{DecToMux[ 0]}} & channels[ 0]) ;

endmodule

//=============================================
//
// Full Adder
//
//=============================================
module FullAdder(A,B,C,carry,sum);
	input A;
	input B;
	input C;
	output carry;
	output sum;
	reg carry;
	reg sum;
//---------------------------------------------	
 
	always @(*) 
	  begin
		sum= A^B^C;
		carry= ((A^B)&C)|(A&B);  
	  end
//---------------------------------------------
endmodule

//-------------------------------------------------
//
// AddSub
//
//-------------------------------------------------


module AddSub(inputA,inputNum2,AddSubFlag,outputNum,carry,OverflowFlag);
    input [15:0] inputA;
    input [15:0] inputNum2;
	input AddSubFlag;
    output [31:0] outputNum;
	output carry;
	output OverflowFlag;

	wire c0; //AddSubFlag assigned to C0

    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15; //XOR Interfaces
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16; //Carry Interfaces
	
	assign c0=AddSubFlag;//AddSubFlag=0, Addition; AddSubFlag=1, Subtraction
	
    assign b0 =  inputNum2[0]  ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b1 =  inputNum2[1]  ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b2 =  inputNum2[2]  ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b3 =  inputNum2[3]  ^ AddSubFlag;//Flip the Bit if Subtraction
	assign b4 =  inputNum2[4]  ^ AddSubFlag;//Flip the Bit if Subtraction
	assign b5 =  inputNum2[5]  ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b6 =  inputNum2[6]  ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b7 =  inputNum2[7]  ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b8 =  inputNum2[8]  ^ AddSubFlag;//Flip the Bit if Subtraction
	assign b9 =  inputNum2[9]  ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b10 = inputNum2[10] ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b11 = inputNum2[11] ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b12 = inputNum2[12] ^ AddSubFlag;//Flip the Bit if Subtraction
	assign b12 = inputNum2[12] ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b13 = inputNum2[13] ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b14 = inputNum2[14] ^ AddSubFlag;//Flip the Bit if Subtraction
    assign b15 = inputNum2[15] ^ AddSubFlag;//Flip the Bit if Subtraction
	
	
	FullAdder FA0 (inputA[0] , b0 , c0 , c1 , outputNum[0]);
	FullAdder FA1 (inputA[1] , b1 , c1 , c2 , outputNum[1]);
	FullAdder FA2 (inputA[2] , b2 , c2 , c3 , outputNum[2]);
	FullAdder FA3 (inputA[3] , b3 , c3 , c4 , outputNum[3]);
	FullAdder FA4 (inputA[4] , b4 , c4 , c5 , outputNum[4]);
	FullAdder FA5 (inputA[5] , b5 , c5 , c6 , outputNum[5]);
	FullAdder FA6 (inputA[6] , b6 , c6 , c7 , outputNum[6]);
	FullAdder FA7 (inputA[7] , b7 , c7 , c8 , outputNum[7]);
	FullAdder FA8 (inputA[8] , b8 , c8 , c9 , outputNum[8]);
	FullAdder FA9 (inputA[9] , b9 , c9 , c10, outputNum[9]);
	FullAdder FA10(inputA[10], b10, c10, c11, outputNum[10]);
	FullAdder FA11(inputA[11], b11, c11, c12, outputNum[11]);
	FullAdder FA12(inputA[12], b12, c12, c13, outputNum[12]);
	FullAdder FA13(inputA[13], b13, c13, c14, outputNum[13]);
	FullAdder FA14(inputA[14], b14, c14, c15, outputNum[14]);
	FullAdder FA15(inputA[15], b15, c15, c16, outputNum[15]);

	assign outputNum[16]=outputNum[15];
	assign outputNum[17]=outputNum[15];
	assign outputNum[18]=outputNum[15];
	assign outputNum[19]=outputNum[15];
	assign outputNum[20]=outputNum[15];
	assign outputNum[21]=outputNum[15];
	assign outputNum[22]=outputNum[15];
	assign outputNum[23]=outputNum[15];
	assign outputNum[24]=outputNum[15];
	assign outputNum[25]=outputNum[15];
	assign outputNum[26]=outputNum[15];
	assign outputNum[27]=outputNum[15];
	assign outputNum[28]=outputNum[15];
	assign outputNum[29]=outputNum[15];
	assign outputNum[30]=outputNum[15];
	assign outputNum[31]=outputNum[15];
	
	assign carry=c16;
	assign OverflowFlag=c16^c15;
endmodule

//=================================================================
//
// Mult
//
//=================================================================
module Mult(inputA,inputNum2,outputNum);
input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;

reg [31:0] outputNum;


reg [15:0] Augend0;
reg [15:0] Addend0;
wire [31:0] Sum0;
wire Carry0;

reg [15:0] Augend1;
reg [15:0] Addend1;
wire [31:0] Sum1;
wire Carry1;

reg [15:0] Augend2;
reg [15:0] Addend2;
wire [31:0] Sum2;
wire Carry2;

reg [15:0] Augend3;
reg [15:0] Addend3;
wire [31:0] Sum3;
wire Carry3;

reg [15:0] Augend4;
reg [15:0] Addend4;
wire [31:0] Sum4;
wire Carry4;

reg [15:0] Augend5;
reg [15:0] Addend5;
wire [31:0] Sum5;
wire Carry5;

reg [15:0] Augend6;
reg [15:0] Addend6;
wire [31:0] Sum6;
wire Carry6;

reg [15:0] Augend7;
reg [15:0] Addend7;
wire [31:0] Sum7;
wire Carry7;

reg [15:0] Augend8;
reg [15:0] Addend8;
wire [31:0] Sum8;
wire Carry8;

reg [15:0] Augend9;
reg [15:0] Addend9;
wire [31:0] Sum9;
wire Carry9;

reg [15:0] Augend10;
reg [15:0] Addend10;
wire [31:0] Sum10;
wire Carry10;

reg [15:0] Augend11;
reg [15:0] Addend11;
wire [31:0] Sum11;
wire Carry11;

reg [15:0] Augend12;
reg [15:0] Addend12;
wire [31:0] Sum12;
wire Carry12;

reg [15:0] Augend13;
reg [15:0] Addend13;
wire [31:0] Sum13;
wire Carry13;

reg [15:0] Augend14;
reg [15:0] Addend14;
wire [31:0] Sum14;
wire Carry14;

reg [15:0] Augend15;
reg [15:0] Addend15;
wire [31:0] Sum15;
wire Carry15;


AddSub add0(Augend0,   Addend0,  1'b0, Sum0 , Carry0,  overflow);
AddSub add1(Augend1,   Addend1,  1'b0, Sum1 , Carry1,  overflow);
AddSub add2(Augend2,   Addend2,  1'b0, Sum2 , Carry2,  overflow);
AddSub add3(Augend3,   Addend3,  1'b0, Sum3 , Carry3,  overflow);
AddSub add4(Augend4,   Addend4,  1'b0, Sum4 , Carry4,  overflow);
AddSub add5(Augend5,   Addend5,  1'b0, Sum5 , Carry5,  overflow);
AddSub add6(Augend6,   Addend6,  1'b0, Sum6 , Carry6,  overflow);
AddSub add7(Augend7,   Addend7,  1'b0, Sum7 , Carry7,  overflow);
AddSub add8(Augend8,   Addend8,  1'b0, Sum8 , Carry8,  overflow);
AddSub add9(Augend9,   Addend9,  1'b0, Sum9 , Carry9,  overflow);
AddSub add10(Augend10, Addend10, 1'b0, Sum10, Carry10, overflow);
AddSub add11(Augend11, Addend11, 1'b0, Sum11, Carry11, overflow);
AddSub add12(Augend12, Addend12, 1'b0, Sum12, Carry12, overflow);
AddSub add13(Augend13, Addend13, 1'b0, Sum13, Carry13, overflow);
AddSub add14(Augend14, Addend14, 1'b0, Sum14, Carry14, overflow);

always@(*)
begin
Augend0 = {1'b0, inputA[0]&inputNum2[15], inputA[0]&inputNum2[14], inputA[0]&inputNum2[13], inputA[0]&inputNum2[12], inputA[0]&inputNum2[11], inputA[0]&inputNum2[10], inputA[0]&inputNum2[9], inputA[0]&inputNum2[8], inputA[0]&inputNum2[7], inputA[0]&inputNum2[6], inputA[0]&inputNum2[5], inputA[0]&inputNum2[4], inputA[0]&inputNum2[3], inputA[0]&inputNum2[2], inputA[0]&inputNum2[1]};
Addend0 = {inputA[1]&inputNum2[15], inputA[1]&inputNum2[14], inputA[1]&inputNum2[13], inputA[1]&inputNum2[12], inputA[1]&inputNum2[11], inputA[1]&inputNum2[10], inputA[1]&inputNum2[9], inputA[1]&inputNum2[8], inputA[1]&inputNum2[7], inputA[1]&inputNum2[6], inputA[1]&inputNum2[5], inputA[1]&inputNum2[4], inputA[1]&inputNum2[3], inputA[1]&inputNum2[2], inputA[1]&inputNum2[1], inputA[1]&inputNum2[0]};

Augend1 = {Carry0, Sum0[15], Sum0[14], Sum0[13], Sum0[12], Sum0[11], Sum0[10], Sum0[9], Sum0[8], Sum0[7], Sum0[6], Sum0[5], Sum0[4], Sum0[3], Sum0[2], Sum0[1]};
Addend1 = {inputA[2]&inputNum2[15], inputA[2]&inputNum2[14], inputA[2]&inputNum2[13], inputA[2]&inputNum2[12], inputA[2]&inputNum2[11], inputA[2]&inputNum2[10], inputA[2]&inputNum2[9], inputA[2]&inputNum2[8], inputA[2]&inputNum2[7], inputA[2]&inputNum2[6], inputA[2]&inputNum2[5], inputA[2]&inputNum2[4], inputA[2]&inputNum2[3], inputA[2]&inputNum2[2], inputA[2]&inputNum2[1], inputA[2]&inputNum2[0]};

Augend2 = {Carry1, Sum1[15], Sum1[14], Sum1[13], Sum1[12], Sum1[11], Sum1[10], Sum1[9], Sum1[8], Sum1[7], Sum1[6], Sum1[5], Sum1[4], Sum1[3], Sum1[2], Sum1[1]};
Addend2 = {inputA[3]&inputNum2[15], inputA[3]&inputNum2[14], inputA[3]&inputNum2[13], inputA[3]&inputNum2[12], inputA[3]&inputNum2[11], inputA[3]&inputNum2[10], inputA[3]&inputNum2[9], inputA[3]&inputNum2[8], inputA[3]&inputNum2[7], inputA[3]&inputNum2[6], inputA[3]&inputNum2[5], inputA[3]&inputNum2[4], inputA[3]&inputNum2[3], inputA[3]&inputNum2[2], inputA[3]&inputNum2[1], inputA[3]&inputNum2[0]};

Augend3 = {Carry2, Sum2[15], Sum2[14], Sum2[13], Sum2[12], Sum2[11], Sum2[10], Sum2[9], Sum2[8], Sum2[7], Sum2[6], Sum2[5], Sum2[4], Sum2[3], Sum2[2], Sum2[1]};
Addend3 = {inputA[4]&inputNum2[15], inputA[4]&inputNum2[14], inputA[4]&inputNum2[13], inputA[4]&inputNum2[12], inputA[4]&inputNum2[11], inputA[4]&inputNum2[10], inputA[4]&inputNum2[9], inputA[4]&inputNum2[8], inputA[4]&inputNum2[7], inputA[4]&inputNum2[6], inputA[4]&inputNum2[5], inputA[4]&inputNum2[4], inputA[4]&inputNum2[3], inputA[4]&inputNum2[2], inputA[4]&inputNum2[1], inputA[4]&inputNum2[0]};

Augend4 = {Carry3, Sum3[15], Sum3[14], Sum3[13], Sum3[12], Sum3[11], Sum3[10], Sum3[9], Sum3[8], Sum3[7], Sum3[6], Sum3[5], Sum3[4], Sum3[3], Sum3[2], Sum3[1]};
Addend4 = {inputA[5]&inputNum2[15], inputA[5]&inputNum2[14], inputA[5]&inputNum2[13], inputA[5]&inputNum2[12], inputA[5]&inputNum2[11], inputA[5]&inputNum2[10], inputA[5]&inputNum2[9], inputA[5]&inputNum2[8], inputA[5]&inputNum2[7], inputA[5]&inputNum2[6], inputA[5]&inputNum2[5], inputA[5]&inputNum2[4], inputA[5]&inputNum2[3], inputA[5]&inputNum2[2], inputA[5]&inputNum2[1], inputA[5]&inputNum2[0]};

Augend5 = {Carry4, Sum4[15], Sum4[14], Sum4[13], Sum4[12], Sum4[11], Sum4[10], Sum4[9], Sum4[8], Sum4[7], Sum4[6], Sum4[5], Sum4[4], Sum4[3], Sum4[2], Sum4[1]};
Addend5 = {inputA[6]&inputNum2[15], inputA[6]&inputNum2[14], inputA[6]&inputNum2[13], inputA[6]&inputNum2[12], inputA[6]&inputNum2[11], inputA[6]&inputNum2[10], inputA[6]&inputNum2[9], inputA[6]&inputNum2[8], inputA[6]&inputNum2[7], inputA[6]&inputNum2[6], inputA[6]&inputNum2[5], inputA[6]&inputNum2[4], inputA[6]&inputNum2[3], inputA[6]&inputNum2[2], inputA[6]&inputNum2[1], inputA[6]&inputNum2[0]};

Augend6 = {Carry5, Sum5[15], Sum5[14], Sum5[13], Sum5[12], Sum5[11], Sum5[10], Sum5[9], Sum5[8], Sum5[7], Sum5[6], Sum5[5], Sum5[4], Sum5[3], Sum5[2], Sum5[1]};
Addend6 = {inputA[7]&inputNum2[15], inputA[7]&inputNum2[14], inputA[7]&inputNum2[13], inputA[7]&inputNum2[12], inputA[7]&inputNum2[11], inputA[7]&inputNum2[10], inputA[7]&inputNum2[9], inputA[7]&inputNum2[8], inputA[7]&inputNum2[7], inputA[7]&inputNum2[6], inputA[7]&inputNum2[5], inputA[7]&inputNum2[4], inputA[7]&inputNum2[3], inputA[7]&inputNum2[2], inputA[7]&inputNum2[1], inputA[7]&inputNum2[0]};

Augend7 = {Carry6, Sum6[15], Sum6[14], Sum6[13], Sum6[12], Sum6[11], Sum6[10], Sum6[9], Sum6[8], Sum6[7], Sum6[6], Sum6[5], Sum6[4], Sum6[3], Sum6[2], Sum6[1]};
Addend7 = {inputA[8]&inputNum2[15], inputA[8]&inputNum2[14], inputA[8]&inputNum2[13], inputA[8]&inputNum2[12], inputA[8]&inputNum2[11], inputA[8]&inputNum2[10], inputA[8]&inputNum2[9], inputA[8]&inputNum2[8], inputA[8]&inputNum2[7], inputA[8]&inputNum2[6], inputA[8]&inputNum2[5], inputA[8]&inputNum2[4], inputA[8]&inputNum2[3], inputA[8]&inputNum2[2], inputA[8]&inputNum2[1], inputA[8]&inputNum2[0]};

Augend8 = {Carry7, Sum7[15], Sum7[14], Sum7[13], Sum7[12], Sum7[11], Sum7[10], Sum7[9], Sum7[8], Sum7[7], Sum7[6], Sum7[5], Sum7[4], Sum7[3], Sum7[2], Sum7[1]};
Addend8 = {inputA[9]&inputNum2[15], inputA[9]&inputNum2[14], inputA[9]&inputNum2[13], inputA[9]&inputNum2[12], inputA[9]&inputNum2[11], inputA[9]&inputNum2[10], inputA[9]&inputNum2[9], inputA[9]&inputNum2[8], inputA[9]&inputNum2[7], inputA[9]&inputNum2[6], inputA[9]&inputNum2[5], inputA[9]&inputNum2[4], inputA[9]&inputNum2[3], inputA[9]&inputNum2[2], inputA[9]&inputNum2[1], inputA[9]&inputNum2[0]};

Augend9 = {Carry8, Sum8[15], Sum8[14], Sum8[13], Sum8[12], Sum8[11], Sum8[10], Sum8[9], Sum8[8], Sum8[7], Sum8[6], Sum8[5], Sum8[4], Sum8[3], Sum8[2], Sum8[1]};
Addend9 = {inputA[10]&inputNum2[15], inputA[10]&inputNum2[14], inputA[10]&inputNum2[13], inputA[10]&inputNum2[12], inputA[10]&inputNum2[11], inputA[10]&inputNum2[10], inputA[10]&inputNum2[9], inputA[10]&inputNum2[8], inputA[10]&inputNum2[7], inputA[10]&inputNum2[6], inputA[10]&inputNum2[5], inputA[10]&inputNum2[4], inputA[10]&inputNum2[3], inputA[10]&inputNum2[2], inputA[10]&inputNum2[1], inputA[10]&inputNum2[0]};

Augend10 = {Carry9, Sum9[15], Sum9[14], Sum9[13], Sum9[12], Sum9[11], Sum9[10], Sum9[9], Sum9[8], Sum9[7], Sum9[6], Sum9[5], Sum9[4], Sum9[3], Sum9[2], Sum9[1]};
Addend10 = {inputA[11]&inputNum2[15], inputA[11]&inputNum2[14], inputA[11]&inputNum2[13], inputA[11]&inputNum2[12], inputA[11]&inputNum2[11], inputA[11]&inputNum2[10], inputA[11]&inputNum2[9], inputA[11]&inputNum2[8], inputA[11]&inputNum2[7], inputA[11]&inputNum2[6], inputA[11]&inputNum2[5], inputA[11]&inputNum2[4], inputA[11]&inputNum2[3], inputA[11]&inputNum2[2], inputA[11]&inputNum2[1], inputA[11]&inputNum2[0]};

Augend11 = {Carry10, Sum10[15], Sum10[14], Sum10[13], Sum10[12], Sum10[11], Sum10[10], Sum10[9], Sum10[8], Sum10[7], Sum10[6], Sum10[5], Sum10[4], Sum10[3], Sum10[2], Sum10[1]};
Addend11 = {inputA[12]&inputNum2[15], inputA[12]&inputNum2[14], inputA[12]&inputNum2[13], inputA[12]&inputNum2[12], inputA[12]&inputNum2[11], inputA[12]&inputNum2[10], inputA[12]&inputNum2[9], inputA[12]&inputNum2[8], inputA[12]&inputNum2[7], inputA[12]&inputNum2[6], inputA[12]&inputNum2[5], inputA[12]&inputNum2[4], inputA[12]&inputNum2[3], inputA[12]&inputNum2[2], inputA[12]&inputNum2[1], inputA[12]&inputNum2[0]};

Augend12 = {Carry11, Sum11[15], Sum11[14], Sum11[13], Sum11[12], Sum11[11], Sum11[10], Sum11[9], Sum11[8], Sum11[7], Sum11[6], Sum11[5], Sum11[4], Sum11[3], Sum11[2], Sum11[1]};
Addend12 = {inputA[13]&inputNum2[15], inputA[13]&inputNum2[14], inputA[13]&inputNum2[13], inputA[13]&inputNum2[12], inputA[13]&inputNum2[11], inputA[13]&inputNum2[10], inputA[13]&inputNum2[9], inputA[13]&inputNum2[8], inputA[13]&inputNum2[7], inputA[13]&inputNum2[6], inputA[13]&inputNum2[5], inputA[13]&inputNum2[4], inputA[13]&inputNum2[3], inputA[13]&inputNum2[2], inputA[13]&inputNum2[1], inputA[13]&inputNum2[0]};

Augend13 = {Carry12, Sum12[15], Sum12[14], Sum12[13], Sum12[12], Sum12[11], Sum12[10], Sum12[9], Sum12[8], Sum12[7], Sum12[6], Sum12[5], Sum12[4], Sum12[3], Sum12[2], Sum12[1]};
Addend13 = {inputA[14]&inputNum2[15], inputA[14]&inputNum2[14], inputA[14]&inputNum2[13], inputA[14]&inputNum2[12], inputA[14]&inputNum2[11], inputA[14]&inputNum2[10], inputA[14]&inputNum2[9], inputA[14]&inputNum2[8], inputA[14]&inputNum2[7], inputA[14]&inputNum2[6], inputA[14]&inputNum2[5], inputA[14]&inputNum2[4], inputA[14]&inputNum2[3], inputA[14]&inputNum2[2], inputA[14]&inputNum2[1], inputA[14]&inputNum2[0]};

Augend14 = {Carry13, Sum13[15], Sum13[14], Sum13[13], Sum13[12], Sum13[11], Sum13[10], Sum13[9], Sum13[8], Sum13[7], Sum13[6], Sum13[5], Sum13[4], Sum13[3], Sum13[2], Sum13[1]};
Addend14 = {inputA[15]&inputNum2[15], inputA[15]&inputNum2[14], inputA[15]&inputNum2[13], inputA[15]&inputNum2[12], inputA[15]&inputNum2[11], inputA[15]&inputNum2[10], inputA[15]&inputNum2[9], inputA[15]&inputNum2[8], inputA[15]&inputNum2[7], inputA[15]&inputNum2[6], inputA[15]&inputNum2[5], inputA[15]&inputNum2[4], inputA[15]&inputNum2[3], inputA[15]&inputNum2[2], inputA[15]&inputNum2[1], inputA[15]&inputNum2[0]};


outputNum[0] = inputA[0]&inputNum2[0]; //From Gates
//=============================
outputNum[1] = Sum0[0];   //From Adder0
//=============================
outputNum[2] = Sum1[0];   //From Adder1
//============================= 
outputNum[3] = Sum2[0];   //From Adder2
//=============================
outputNum[4] = Sum3[0];   //From Adder3
//=============================
outputNum[5] = Sum4[0];   //From Adder4
//=============================
outputNum[6] = Sum5[0];   //From Adder5
//=============================
outputNum[7] = Sum6[0];   //From Adder6
//=============================
outputNum[8] = Sum7[0];   //From Adder7
//=============================
outputNum[9] = Sum8[0];   //From Adder8
//=============================
outputNum[10] = Sum9[0];  //From Adder9
//=============================
outputNum[11] = Sum10[0]; //From Adder10
//=============================
outputNum[12] = Sum11[0]; //From Adder11
//=============================
outputNum[13] = Sum12[0]; //From Adder12
//=============================
outputNum[14] = Sum13[0]; //From Adder13
//=============================
outputNum[15] = Sum14[0];  //Remaining from Adder14
outputNum[16] = Sum14[1];
outputNum[17] = Sum14[2];
outputNum[18] = Sum14[3];
outputNum[19] = Sum14[4];
outputNum[20] = Sum14[5];
outputNum[21] = Sum14[6];
outputNum[22] = Sum14[7];
outputNum[23] = Sum14[8];
outputNum[24] = Sum14[9];
outputNum[25] = Sum14[10];
outputNum[26] = Sum14[11];
outputNum[27] = Sum14[12];
outputNum[28] = Sum14[13];
outputNum[29] = Sum14[14];
outputNum[30] = Sum14[15];
outputNum[31] = Carry14;

 end
endmodule

//-------------------------------------------------
//
// Div (Behavioral)
//
//-------------------------------------------------


module Div(inputA,inputNum2,outputNum,DivZero);
input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;
output DivZero;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;
reg DivZero;

always @(inputA,inputNum2)
begin
outputNum=inputA/inputNum2;
outputNum[16]=outputNum[15];
outputNum[17]=outputNum[15];
outputNum[18]=outputNum[15];
outputNum[19]=outputNum[15];
outputNum[20]=outputNum[15];
outputNum[21]=outputNum[15];
outputNum[22]=outputNum[15];
outputNum[23]=outputNum[15];
outputNum[24]=outputNum[15];
outputNum[25]=outputNum[15];
outputNum[26]=outputNum[15];
outputNum[27]=outputNum[15];
outputNum[28]=outputNum[15];
outputNum[29]=outputNum[15];
outputNum[30]=outputNum[15];
outputNum[31]=outputNum[15];

DivZero=~(inputNum2[15]|inputNum2[14]|inputNum2[13]|inputNum2[12]|
		inputNum2[11]|inputNum2[10]|inputNum2[9]|inputNum2[8]|
		inputNum2[7]|inputNum2[6]|inputNum2[5]|inputNum2[4]|
		inputNum2[3]|inputNum2[2]|inputNum2[1]|inputNum2[0]);
end

endmodule

//-------------------------------------------------
//
// Mod
//
//-------------------------------------------------


module Mod(inputA,inputNum2,outputNum,ModZero);

input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;
output ModZero;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;
reg ModZero;

always @(inputA,inputNum2)
begin
outputNum=inputA%inputNum2;
outputNum[16]=outputNum[15];
outputNum[17]=outputNum[15];
outputNum[18]=outputNum[15];
outputNum[19]=outputNum[15];
outputNum[20]=outputNum[15];
outputNum[21]=outputNum[15];
outputNum[22]=outputNum[15];
outputNum[23]=outputNum[15];
outputNum[24]=outputNum[15];
outputNum[25]=outputNum[15];
outputNum[26]=outputNum[15];
outputNum[27]=outputNum[15];
outputNum[28]=outputNum[15];
outputNum[29]=outputNum[15];
outputNum[30]=outputNum[15];
outputNum[31]=outputNum[15];

ModZero=~(inputNum2[15]|inputNum2[14]|inputNum2[13]|inputNum2[12]|
		inputNum2[11]|inputNum2[10]|inputNum2[9]|inputNum2[8]|
		inputNum2[7]|inputNum2[6]|inputNum2[5]|inputNum2[4]|
		inputNum2[3]|inputNum2[2]|inputNum2[1]|inputNum2[0]);
end

endmodule
//=================================================================
//
//AND
//
//=================================================================
module And(inputA, inputNum2, outputNum);

input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;

always @(inputA, inputNum2)
begin
outputNum[15:0] = inputA[15:0] & inputNum2[15:0];
outputNum[31:16] = 16'b0;

outputNum[31:16] = 16'b0;
end

endmodule
//=================================================================
//
//OR
//
//=================================================================
module Or(inputA, inputNum2, outputNum);

input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;

always @(inputA, inputNum2)
begin
outputNum[15:0] = inputA[15:0] | inputNum2[15:0];
outputNum[31:16] = 16'b0;
end

endmodule
//=================================================================
//
//NOT
//
//=================================================================
module Not(feedback_input, outputNum);

input [31:0] feedback_input;
output [31:0] outputNum;

wire [31:0] feedback_input;
reg [31:0] outputNum;

always @(feedback_input)
begin
outputNum = ~feedback_input;
end

endmodule
//=================================================================
//
//XOR
//
//=================================================================
module Xor(inputA, inputNum2, outputNum);

input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;

always @(inputA, inputNum2)
begin
outputNum[15:0] = inputA[15:0] ^ inputNum2[15:0];
outputNum[31:16] = 16'b0;
end

endmodule
//=================================================================
//
//Nand
//
//=================================================================
module Nand(inputA, inputNum2, outputNum);

input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;

always @(inputA, inputNum2)
begin
outputNum[15:0] = ~(inputA[15:0] & inputNum2[15:0]);
outputNum[31:16] = 16'b0;
end

endmodule
//=================================================================
//
//Nor
//
//=================================================================
module Nor(inputA, inputNum2, outputNum);

input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;

always @(inputA, inputNum2)
begin
outputNum[15:0] = ~(inputA[15:0] | inputNum2[15:0]);
outputNum[31:16] = 16'b0;
end

endmodule
//=================================================================
//
//XNOR
//
//=================================================================
module Xnor(inputA, inputNum2, outputNum);

input [15:0] inputA;
input [15:0] inputNum2;
output [31:0] outputNum;

wire [15:0] inputA;
wire [15:0] inputNum2;
reg [31:0] outputNum;

always @(inputA, inputNum2)
begin
outputNum[15:0] = ~(inputA[15:0] ^ inputNum2[15:0]);
outputNum[31:16] = 16'b0;
end

endmodule



//=================================================================
//
//Breadboard
//
// Parameter Definitions
// inputA: 			1st 16-bit integer operand that will be fed into arithmetic modules
// inputNum2: 			2nd 16-bit integer operand that will be fed into arithmetic modules
// outputNum:			32-bit integer output of the operations performed by the arithmetic modules
// opcode:     			4-bit operational code that determines which operation will be performed on the operands
// err:					2-bit err code. Most significant bit represents divide by zero err and least significant bit represents overflow err
// opcode definitions:	0000 - No Operation
//						0001 - Reset (All 0s in the Register)
//						0010 - AND
//						0011 - OR
//						0100 - Addition
//						0101 - Subtraction
//						0110 - Multiplication
//						0111 - Division
//						1000 - Modulo
//						1001 - NOT
//						1010 - XOR
//						1011 - NAND
//						1100 - NOR
//						1101 - XNOR
//						1110 - Unused
//						1111 - Preset (All 1s in the Register)(
//						
//=================================================================
module breadboard(clk, inputA, outputNum, opcode, err);
input clk;
input reset; 

input [15:0] inputA;
input [3:0] opcode; 

wire clk;

wire [15:0] inputA;
wire [3:0] opcode;

output [1:0]err;
reg [1:0]err;
//----------------------------------
output [31:0] outputNum;
reg [31:0] outputNum;

//=======================================================
//
// CONTROL
//
//========================================================
wire [15:0][31:0]channels;
wire [15:0] DecToMux;
wire [31:0] b; 
wire [1:0] unknown;

Dec		 	dec1(opcode,DecToMux);
Mux 		mux1(channels,DecToMux,b); 

//----------------------------------
//========================================================
//
// Register
//
//========================================================
reg  [31:0] next;
wire [31:0] current;

reg [31:0] feedback_input;

DFF ACC[31:0] (clk, next, current);
//=======================================================
//
// OPERATIONS
//
//=======================================================
wire [31:0] Reset  = 32'b00000000000000000000000000000000;
wire [31:0] Preset = 32'b11111111111111111111111111111111;
wire [31:0] AndToMux;
wire [31:0] OrToMux;
wire [31:0] NotToMux;
wire [31:0] XorToMux;
wire [31:0] NandToMux;
wire [31:0] NorToMux;
wire [31:0] XnorToMux;
wire [31:0] AddSubToMux;
wire OverflowFlag;
wire [31:0] MultToMux;
wire [31:0] DivToMux;
wire DivZero;
wire [31:0] ModToMux;
wire ModZero;

And 		and1 (feedback_input[15:0]	, inputA, AndToMux);
Or			or1  (feedback_input[15:0]	, inputA, OrToMux);
AddSub		add1 (feedback_input[15:0]	, inputA, DecToMux[5],AddSubToMux,Carry,OverflowFlag);
Mult		mul1 (feedback_input[15:0]	, inputA, MultToMux);
Div			div1 (feedback_input[15:0]	, inputA, DivToMux,DivZero);
Mod			mod1 (feedback_input[15:0]	, inputA, ModToMux,ModZero); 
Not			not1 (feedback_input		, NotToMux);
Xor			xor1 (feedback_input[15:0]	, inputA, XorToMux);
Nand		nand1(feedback_input[15:0]	, inputA, NandToMux);
Nor			nor1 (feedback_input[15:0]	, inputA, NorToMux);
Xnor		xnor1(feedback_input[15:0]	, inputA, XnorToMux);

//=======================================================
// Error 
//=======================================================
wire DivByZeroFlag;

assign DivByZeroFlag = DivZero|ModZero;

//=======================================================
//
// Connect the MUX to the OpCodes
//
// Channel 4, Opcode 0100, Addition
// Channel 5, Opcode 0101, Subtraction
// Channel 6, Opcode 0110, Mulitplication
// Channel 7, Opcode 0111, Division (Behavioral)
// Channel 8, Opcode 1000, Modulo (Behavioral)
// 0000 – No-op (Feedback output from memory register)
// 0001 – Reset (Set all 0)
// 0010 – AND
// 0011 – OR
// 0100 – Addition (AddSub)
// 0101 – Subtraction (AddSub)
// 0110 – Multiplication (Mult)
// 0111 – Division (Div)
// 1000 – Modulo (Mod)
// 1001 – NOT
// 1010 – XOR
// 1011 – NAND
// 1100 – NOR
// 1101 – XNOR 
// 1110 – Unknown
// 1111 – Preset (Set all 1)
//
//=======================================================
assign channels[ 0]=current; 		//noop
assign channels[ 1]=Reset;			//reset 
assign channels[ 2]=AndToMux;		//AND
assign channels[ 3]=OrToMux;		//OR
assign channels[ 4]=AddSubToMux;	//Addition
assign channels[ 5]=AddSubToMux;	//Subtraction
assign channels[ 6]=MultToMux;		//Multiplication`
assign channels[ 7]=DivToMux;		//Division
assign channels[ 8]=ModToMux;		//Modulus
assign channels[ 9]=NotToMux;		//NOT
assign channels[10]=XorToMux;		//XOR
assign channels[11]=NandToMux;		//NAND
assign channels[12]=NorToMux;		//NOR
assign channels[13]=XnorToMux;		//XNOR
assign channels[14]=unknown;		//Unused
assign channels[15]=Preset;			//Preset (all 1s)	

//====================================================
//
//Perform the gate-level operations in the Breadboard
//
//====================================================
always@(*)
begin
	feedback_input = current;
	
	err[0]=OverflowFlag&(DecToMux[4]|DecToMux[5]);//Only show overflow if in add or subtract operation
	err[1]=DivByZeroFlag&(DecToMux[7]|DecToMux[8]);//only show divide by zero if in division or modulo operation
	
	if (opcode==4'b1)
		begin
			err = 2'b00;
		end
		
	assign outputNum = current;
	assign next = b;	
end

endmodule

`define NO_OP  4'b0000
`define RESET  4'b0001
`define AND    4'b0010
`define OR     4'b0011
`define ADD    4'b0100
`define SUB    4'b0101
`define MULT   4'b0110
`define DIV    4'b0111
`define MOD    4'b1000
`define NOT    4'b1001
`define XOR    4'b1010
`define NAND   4'b1011
`define NOR    4'b1100
`define XNOR   4'b1101
`define PRESET 4'b1111

`define PI 16'd314

`define TICK(OPCODE, INPUT=16'bzzzzzzzzzzzzzzzz) inputA = INPUT; opcode = `OPCODE; #10

//====================================================
//
//TEST BENCH
//
//====================================================
module testbench();

//====================================================
//
//Local Variables
//
//====================================================
   reg clk;
   reg  [15:0] inputA;
   reg  [3:0] opcode;
   wire [31:0] outputNum;
   wire [1:0] err; 
   reg [15:0] sideA;
   reg [15:0] sideB;
   reg [15:0] sideC;
   reg [15:0] baseSide;
   reg [15:0] height;
   reg [15:0] radius;
   reg [15:0] temp;
   reg [31:0] hold;
   reg [15:0] whole;
   reg [15:0] fraction;
   
//====================================================
//
// Create Breadboard
//
//====================================================
	breadboard mahogany(clk,inputA,outputNum,opcode,err);

//====================================================
// 
// Start Clock
//
//====================================================
	initial begin
		forever
			begin
				clk = 0;
				#5;
				clk = 1;
				#5;
			end
	end
	
	initial begin//Start Stimulous Thread
		#6;
		$display("=========================================================");
		$display("======== Surface Area and Volume of a Cylinder ==========");
		// Set Height and Radius
		radius = 16'd5;
		height = 16'd7;
		$display("Radius		=		%5d units", radius);
		$display("Height		=		%5d units", height);
		$display("---------------------------------------------------------");
		// Surface Area = 2*pi*radius*(radius + height)
		// Radius + Height
		`TICK(RESET);
		`TICK(ADD, radius);
		`TICK(ADD, height);
		`TICK(NO_OP);
		hold = mahogany.next;
		// multiply by radius
		`TICK(MULT, radius);
		// multiply by pi
		`TICK(MULT, `PI);
		// multiply by 2
		`TICK(MULT, 16'd2);
		`TICK(NO_OP);
		hold = mahogany.next;
		// get whole number
		`TICK(DIV, 16'd100);
		`TICK(NO_OP);
		whole = mahogany.next;
		//get fractional		
		`TICK(RESET);
		`TICK(ADD, hold);
		`TICK(MOD, 16'd100);
		`TICK(NO_OP);
		fraction = mahogany.next;
		$display("Surface Area	=		%5d.%-3d units squared", whole, fraction);
		//Volume = Pi * radius^2 * height
		//reset
		`TICK(RESET);
		// radius^2
		`TICK(ADD, radius);
		`TICK(MULT, radius);
		// Multiply height
		`TICK(MULT, height);
		// multiply pi
		`TICK(MULT, `PI);
		`TICK(NO_OP);
		hold = mahogany.next;
		//get whole
		`TICK(DIV, 16'd100);
		`TICK(NO_OP);
		whole = mahogany.next;
		//get fraction 
		//reset 
		`TICK(RESET);
		`TICK(ADD, hold);
		`TICK(MOD, 16'd100);
		`TICK(NO_OP);
		fraction = mahogany.next;
		$display("Volume		=		%5d.%-3d units cubed", whole, fraction);
		$display("=========================================================");
		$display();
		
		// Triangle
		$display("=========================================================");
		$display("=========== Area and Perimeter of a Triangle ===========");
		//Perimeter = sideA + sideB + sideC
		//RESET
		`TICK(RESET);
		//Set side lengths
		sideA = 16'b0000000001010110;
		sideB = 16'b0000000000111010;
		sideC = 16'b0000000000110101;
		$display("Side Lengths	=	%5d units x %5d units x %5d units",sideA, sideB, sideC);
		// Add sides together
		`TICK(ADD, sideA);
		`TICK(ADD, sideB);
		`TICK(ADD, sideC);
		`TICK(NO_OP);
		$display("Perimeter	=	%5d units", mahogany.next);
		$display("---------------------------------------------------------");
		// RESET
		`TICK(RESET);
		//Set base and height             
		baseSide = 16'b0000000000001011;
		height = 16'b0000000000000101;
		$display("Base x Height Lengths	=       %5d units x %5d units",baseSide, height);
		// Area = 1/2 * Base * Height
		//Multiply base x height
		`TICK(ADD, baseSide);
		`TICK(MULT, height);
		//Get whole and fraction parts
		//Multiply by 50
		`TICK(MULT, 16'd50);
		`TICK(NO_OP);
		hold = mahogany.next;
		//Get whole number
		//Divide by 100		
		`TICK(DIV, 16'd100);
		`TICK(NO_OP);
		whole = mahogany.next;
		//Reset
		`TICK(RESET);
		//Get fraction
		//Modulo hold by 100
		`TICK(ADD, hold);
		`TICK(MOD, 16'd100);
		`TICK(NO_OP);
		fraction = mahogany.next;
		$display("Area			=       %5d.%-3d units squared", whole, fraction);
		$display("=========================================================");
		$display();
		$display();
		$display("=========================================================");
		$display("=========== Area and Perimeter of a Square ===========");
		// RESET
		`TICK(RESET);
		//Set side lengths
		sideA = 16'b0000000000010101;
		$display("Side Length  =       %5d units",sideA);           
		// Perimeter = 4*Side
		//Multiply side length by 4
		`TICK(ADD, sideA);
		`TICK(MULT, 16'b0000000000000100);
		//No-op
		`TICK(NO_OP);
		$display("Perimeter     =       %5d units", mahogany.next);
		//RESET
		`TICK(RESET);
		// Area = Side^2
		//Multiply side by side
		`TICK(ADD, sideA);
		`TICK(MULT, sideA);
		//NO-OP
		`TICK(NO_OP);
		$display("Area          =       %5d units squared", mahogany.next);
		$display("=========================================================");                             

		// Perimeter and Area of a Rectangle
		$display();	
		$display();
		$display("=========================================================");
		$display("=========== Area and Perimeter of a Rectangle ===========");
		// RESET
		`TICK(RESET);
		// Perimeter = 2 * (length + width)
		// Set side lengths
		sideA = 16'b0000000001100100;
		sideB = 16'b0000001001100100;		
		`TICK(ADD, sideA);
		$display("Side Lengths	=	%5d units x %5d units",sideA, sideB);		
		// Add sides together
		`TICK(ADD, sideB);
		// multiply by 2
		`TICK(MULT, 16'b0000000000000010);
		`TICK(NO_OP);
		$display("Perimeter	=	%5d units", mahogany.next);		
		// RESET
		`TICK(RESET);
		// Area = Length * Width
		// Multiply side a and b together
		`TICK(ADD, sideA);
		`TICK(MULT, sideB);
		`TICK(NO_OP, 16'b0);
		$display("Area		=	%5d units squared", mahogany.next);
		$display("=========================================================");
		$display();
		$display();
		$display("=========================================================");
		$display("=========== Circumference and Area of a Circle ==========");
		radius = 16'b0000000000001101;
		$display("Radius		=	%5d units", radius);
		// Circumference = 2 * Pi * radius
		// RESET		
		`TICK(RESET);
		// Set Pi
		`TICK(ADD, `PI);
		// Multiply by 2
		`TICK(MULT, 16'b0000000000000010);
		// multiply the radius 
		`TICK(MULT, radius);
		`TICK(NO_OP, radius);
		hold = mahogany.next;
		// Get whole number
		`TICK(DIV, 16'd100);
		`TICK(NO_OP);
		whole = mahogany.next;
		`TICK(RESET);
		//Get fractional
		`TICK(ADD, hold);
		`TICK(MOD, 16'd100);
		`TICK(NO_OP);
		fraction = mahogany.next;
		$display("Circumference	=	%5d.%-3d units", whole, fraction);		
		// Area = Pi* radius ^2
		// RESET		
		`TICK(RESET);
		// Set Pi
		`TICK(ADD, `PI);
		// Multiply by radius^2
		`TICK(MULT, radius);
		`TICK(MULT, radius);
		`TICK(NO_OP);
		hold = mahogany.next;
		// get whole
		`TICK(DIV, 16'd100);
		`TICK(NO_OP);
		whole = mahogany.next;
		// get fraction
		`TICK(RESET);
		`TICK(ADD, hold);
		`TICK(MOD, 16'd100);
		`TICK(NO_OP);
		fraction = mahogany.next;
		$display("Area		=	%5d.%-3d units squared", whole, fraction);		
		$display("=========================================================");
		$display();
		$display();
		$display("=========================================================");
		$display("========== Surface Area and Volume of a Sphere ==========");
		// Surface Area = 4 * Pi * radius^2
		// RESET		
		`TICK(RESET);
		// Set radius. 
		radius = 16'b0000000000000011;
		$display("Radius		=	%5d units", radius);
		// Start with 4
		`TICK(ADD, 16'b0000000000000100);
		// Multiply Pi
		`TICK(MULT, `PI);
		// Multiply the radius twice
		`TICK(MULT, radius);
		`TICK(MULT, radius);
		`TICK(NO_OP);
		hold = mahogany.next;		
		
		// get whole number
		`TICK(DIV, 16'd100);
		`TICK(NO_OP);
		whole = mahogany.next;
		// RESET
		`TICK(RESET);
		// get fraction
		`TICK(ADD, hold);
		`TICK(MOD, 16'd100);
		`TICK(NO_OP);
		fraction = mahogany.next;
		$display("Surface Area	=	%5d.%-3d units squared", whole, fraction);
		// Surface Area = 4/3 * PI * radius^3
		// RESET
		`TICK(RESET);
		// Start with 4
		`TICK(ADD, 16'b0000000000000100);
		// multiply pi
		`TICK(MULT, `PI);
		`TICK(NO_OP);
		// radius ^ 3
		`TICK(MULT, radius);
		`TICK(MULT, radius);
		`TICK(MULT, radius);
		`TICK(NO_OP);
		// Divide by 3
		`TICK(DIV, 16'b0000000000000011);
		hold = mahogany.next;
		// Get whole number
		`TICK(DIV, 16'd100);
		`TICK(NO_OP);
		whole = mahogany.next;
		// RESET
		`TICK(RESET);
		// get fraction
		`TICK(ADD, hold);
		`TICK(MOD, 16'd100);
		`TICK(NO_OP);
		$display("Volume		=	%5d.%-3d units cubed", whole, fraction);
		$display("=========================================================");
		$display();	
		$finish;
	end 

endmodule
