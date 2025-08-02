`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2025 03:27:12 PM
// Design Name: 
// Module Name: hex_to_ssd
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


module hex_to_ssd(
    input [3:0] hex,
    output reg [6:0]ssd
    );
    parameter hex0=0,hex1=1,hex2=2,hex3=3,hex4=4,hex5=5,hex6=6,hex7=7,hex8=8,hex9=9,hexA=10,hexB=11,hexC=12,hexD=13,hexE=14,hexF=15;
       always @(*) begin
        case (hex)
            4'h0: ssd[6:0] = 7'b0111111;
            4'h1: ssd[6:0] = 7'b0000110;
            4'h2: ssd[6:0] = 7'b1011011;
            4'h3: ssd[6:0] = 7'b1001111;
            4'h4: ssd[6:0] = 7'b1100110;
            4'h5: ssd[6:0] = 7'b1101101;
            4'h6: ssd[6:0] = 7'b1111101;
            4'h7: ssd[6:0] = 7'b0000111;
            4'h8: ssd[6:0] = 7'b1111111;
            4'h9: ssd[6:0] = 7'b1101111;
            4'hA: ssd[6:0] = 7'b1110111;
            4'hB: ssd[6:0] = 7'b1111100;
            4'hC: ssd[6:0] = 7'b1011000;
            4'hD: ssd[6:0] = 7'b1011110;
            4'hE: ssd[6:0] = 7'b1111001;
            4'hF: ssd[6:0] = 7'b1110001;
        endcase
    end
    

endmodule
