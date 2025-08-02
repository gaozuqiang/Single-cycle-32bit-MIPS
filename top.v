`timescale 1ns / 1ps

module top(
    input clk,
    input reset,
    output [6:0] ssd,
    output reg ssd_digit_sel
    );
    
    wire [31:0] PC;
    wire [3:0] PC_hex [7:0];
    wire [3:0] current_digit;
    //reg reset;
    //reg clk;
    wire clk_en;
    //reg clk_ssd;
    //integer i;
    
    mip imip(
        .clk(clk_en),
        .reset(reset),
        .PC(PC)
    );
    
    hex_to_ssd issd1(
        .ssd(ssd),
        .hex(current_digit)
    );
    
    assign PC_hex[0] = PC[3:0];
    assign PC_hex[1] = PC[7:4];
    assign PC_hex[2] = PC[11:8];
    assign PC_hex[3] = PC[15:12];
    assign PC_hex[4] = PC[19:16];
    assign PC_hex[5] = PC[23:20];
    assign PC_hex[6] = PC[27:24];
    assign PC_hex[7] = PC[31:30];
    
    // generate slower clk signal for human eye
	reg [31:0] clk_count;
	always @ (posedge clk or posedge reset)
	begin
		if (reset) begin
		clk_count <= 0;
		end
		else begin
			clk_count <= clk_count+1'b1;
	    end
	end
    assign clk_en = &clk_count;
    
   always @(posedge clk or posedge reset) begin
       if(reset) ssd_digit_sel <= 0;
       else ssd_digit_sel <= ~ssd_digit_sel;
   end
    
   
   assign current_digit = PC_hex[ssd_digit_sel]; 
   
    
endmodule
