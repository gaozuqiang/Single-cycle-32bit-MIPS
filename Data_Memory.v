`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 10:37:27 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input [5:0] Address,
    input [31:0] WriteData,
    input Memwrite,
    input clk,
    output [31:0] Readdata
    );
    
    reg[31:0] DataAddress[63:0];
    
    initial begin
        $readmemh("datamem.mem", DataAddress);
    end
    
    assign Readdata= DataAddress[Address];
    
   always @(posedge clk) begin
        if (Memwrite) DataAddress[Address] <= WriteData;
     end
           
    
    
endmodule
