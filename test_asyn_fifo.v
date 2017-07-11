`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:42:51 07/08/2017
// Design Name:   Asyn_fifo_CQ
// Module Name:   E:/VLSI_Programs/Mem_Proj31/test_asyn_fifo.v
// Project Name:  Mem_Proj31
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Asyn_fifo_CQ
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_asyn_fifo;

	// Inputs
	reg [3:0] data_in;
	reg rclk;
	reg wclk;
	reg r_en;
	reg w_en;

	// Outputs
	wire [3:0] data_out;
	wire mem_full;
	wire mem_empty;

	// Instantiate the Unit Under Test (UUT)
	Asyn_fifo_CQ uut (
		.data_out(data_out), 
		.mem_full(mem_full), 
		.mem_empty(mem_empty), 
		.data_in(data_in), 
		.rclk(rclk), 
		.wclk(wclk), 
		.r_en(r_en), 
		.w_en(w_en)
	);

	initial begin
	
	#10; w_en=1; wclk=1; data_in=4'b0011;
	#10; wclk=0;
	#10; w_en=1; r_en=1; wclk=1; rclk=1; data_in=4'b1001;
	#10; w_en=0; r_en=0;
	#10; w_en=1; wclk=1; data_in=4'b0111;
	#10; wclk=0;
	#10; w_en=1; wclk=1; data_in=4'b1111;
	#10; wclk=0;
	#10; r_en=1; rclk=1; 
	#10; r_en=0; rclk=0;
	#10; w_en=1; wclk=1; data_in=4'b0000;
	#10; wclk=0;
	w_en=0;
	
	
	#10; r_en=1; rclk=1; 
	#10; r_en=0; rclk=0;
	#10; r_en=1; rclk=1; 
	#10; r_en=0; rclk=0;
	#10; r_en=1; rclk=1; 
	#10; r_en=0; rclk=0;
	#10; r_en=1; rclk=1; 
	r_en=0;
	
	end
   
	initial 
	$monitor("time=%d,r_en=%b,w_en=%b,data_in=%b: data_out=%b,mem_full=%b,mem_empty=%b",$time,r_en,w_en,data_in,data_out,mem_full,mem_empty);
endmodule

