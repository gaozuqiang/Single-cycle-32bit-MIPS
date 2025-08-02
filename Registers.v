`timescale 1ns / 1ps

module Registers(
    input [4:0] readregister1,
    input [4:0] readregister2,
    input [4:0] Writeregister,
    input [31:0] Writedata,
    input RegWrite,
    input clk,
    output [31:0] Readdata1,
    output [31:0] Readdata2
    );
    
    reg [31:0] Register_Address [31:0]; // Array holding memory of 32 entries each 32 bits
    
    initial
        begin
        $readmemh("regmem.mem", Register_Address);
        end
    
    always@(posedge clk) begin
        if (RegWrite) Register_Address[Writeregister]<=Writedata;
    end
        
    assign Readdata1 = Register_Address[readregister1];
    assign Readdata2 = Register_Address[readregister2];
    
endmodule
