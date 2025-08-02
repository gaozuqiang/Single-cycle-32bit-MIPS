`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 08:27:29 PM
// Design Name: 
// Module Name: mip
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


module mip(
        input clk,
        input reset,
        output reg [31:0] PC
    );
    //Address control
    wire [31:0] PCPlus4;
    wire [31:0] PCbar;     // Next state value of the Program counter, PC' in the diagram
    wire [31:0] PCCalc;    // Calculated value for the (next) PC
    wire [31:0] PCJump;    // Value for immediate jump
	wire [31:0] PCBranch;  // Value calculated for the branch instructions
    
    
    
    //Instruction_Memory
    wire [31:0]instruction;
    wire [4:0] Writeregister;
      
     
    
    //ALU & Reg
    wire [31:0]readdata2;
    wire [31:0]alusrc_a;
    wire [31:0]alusrc_b;
    wire [31:0] ALU_result;
    wire zero;
    wire [31:0] Writedata;
    
    //control
    wire RegDst;
    wire [5:0]ALUControl;
    wire ALUSrc;
    wire Branch;
    wire MemtoReg;
    wire MemWrite;
    wire RegWrite;
    wire Jump;
    
    //signimediate
    wire [31:0] SignImm;
    
    //DataMemory
    wire [31:0] Readdata_mem;
    
    always @ ( posedge clk, posedge reset ) 
	  if    (reset== 1'b1) PC <= 32'h00000000; // default program counter 
	  else                    PC <= PCbar;        // Copy next value to present
	  
    // Calculation of the next PC value
    assign PCPlus4  = PC + 4;                             // By default the PC increments by 4
    assign PCBranch = PCPlus4 + {SignImm[29:0],2'b00};    
    assign PCCalc = PCSrc ? PCBranch : PCPlus4;           // Multiplexer selects Branch or only +4
    assign PCJump = {PCPlus4[31:28], instruction[25:0], 2'b00}; // The Jump value
    assign PCbar  = Jump  ? PCJump   : PCCalc;            // Multiplexer selects Jump or Normal

    assign SignImm = {{16{instruction[15]}},instruction[15:0]};
    
    assign Writeregister = RegDst ? instruction[15:11] : instruction[20:16]; //mux register for register write register
    assign alusrc_b = ALUSrc ? SignImm:readdata2 ; 
    assign Writedata = MemtoReg ? Readdata_mem:ALU_result; //mux register for register writedata
    assign PCSrc = Branch & zero;                // simple AND
        
    Instruction_Memory im(
    .Read_address(PC[7:2]),
    .instruction(instruction)
    
    );
    
    Registers ireg(
    .readregister1(instruction[25:21]),
    .readregister2(instruction[20:16]),
    .Writeregister(Writeregister),
    .Writedata(Writedata),
    .Readdata1(alusrc_a),
    .Readdata2(readdata2),
    .clk(clk),
    .RegWrite(RegWrite)
    );
    
    ALU ialu(
    .a(alusrc_a),
    .b(alusrc_b),
	.aluop(ALUControl[3:0]),
	.ALU_result(ALU_result),
	.zero(zero)
    );
    
    Control icon(
    .Op(instruction[31:26]),
    .Funct(instruction[5:0]),
    .RegDst(RegDst),
    .Branch(Branch),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Jump(Jump),
    .ALUControl(ALUControl)
    );
    
    Data_Memory imem(
    .Address(ALU_result[5:0]),
    .WriteData(readdata2),
    .Memwrite(MemWrite),
    .Readdata(Readdata_mem),
    .clk(clk)
    );
   
    
endmodule
