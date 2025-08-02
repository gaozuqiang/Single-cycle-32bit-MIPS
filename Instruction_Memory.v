`timescale 1ns / 1ps

module Instruction_Memory(
    input [5:0]Read_address, // Address of the Instruction max 64 instructions
    output [31:0] instruction
    );
    
    reg[31:0] Instruction_Address [63:0]; // Array holding the memory 64 entries each 32 bits
    
    initial
        begin
        $readmemh("insmem.mem",Instruction_Address);
        end
        
    assign instruction = Instruction_Address[Read_address];
endmodule
