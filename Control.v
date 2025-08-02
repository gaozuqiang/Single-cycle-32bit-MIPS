`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 07:33:25 PM
// Design Name: 
// Module Name: Control
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


module Control(
    input [5:0]Op,
    input [5:0] Funct,
    output RegDst,
    output Branch,
    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output Jump,
    output [5:0] ALUControl
    );
    
    localparam [5:0] OP_RTYPE = 6'b000000;  // There is an R-Type of Operation
    localparam [5:0] OP_LW    = 6'b100011;  // The Load Word operation
    localparam [5:0] OP_SW    = 6'b101011;  // The Store Word operation
    localparam [5:0] OP_BEQ   = 6'b000100;  // The Branch on Equal operation
    localparam [5:0] OP_ADDI  = 6'b001000;  // The ADDimmediate operation
    localparam [5:0] OP_J     = 6'b000010;  // The Jump operation
    
    // We will write to registers when OP is Rtype or LW or ADDI 
    assign RegWrite = (Op == OP_RTYPE) | (Op == OP_LW) | ( Op == OP_ADDI) ; 	 
    // Select the input of the ALU
    assign ALUSrc   = (Op == OP_LW) | (Op == OP_SW) | (Op == OP_ADDI) ;
        
    assign RegDst   = (Op == OP_RTYPE); // The destination is a register
    assign Branch   = (Op == OP_BEQ);   // 1: if there is a branch instruction 
    assign MemWrite = (Op == OP_SW);    // 1: for Store Word
    assign MemtoReg = (Op == OP_LW);	   // 1: when Load Word
    assign Jump     = (Op == OP_J);	   // 1: when Jump
    
    assign ALUControl = ALUSrc ? 6'b100000 :  // if LW, SW or ADDI, perform an ADD
                        Branch ? 6'b100010 :   // if BEQ, perform a SUB
			                           Funct; //default R type
	 
endmodule
