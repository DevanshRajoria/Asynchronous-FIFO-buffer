`timescale 1ns / 1ps
`include "fifo.v"

module fifo_tb;

parameter data_width = 4;
parameter addr_width = 4;

reg [data_width - 1:0] fifo_in;
reg re;
reg we;
reg clk;
reg rst;

wire [data_width - 1:0] fifo_out;
wire overflow;
wire underflow;

fifo uut(
		.fifo_out(fifo_out),
		.overflow(overflow),
		.underflow(underflow),
		.fifo_in(fifo_in),
		.re(re),
		.we(we),
		.clk(clk),
		.rst(rst)
	);

initial begin
	forever #5 clk = ~clk;
end

initial begin
	clk = 0;
 	
	#5 rst = 1;
	#2 rst = 0;
end

initial begin
	#15 re = 1; fifo_in = 4'h1;
	#10 fifo_in = 4'h4;
	#10 fifo_in = 4'ha;
	#10 fifo_in = 4'h8;
	#10 fifo_in = 4'hc;

	#10 re = 0; we = 1; 
	#50 we = 0; 
	#20 $finish;

end

initial begin
	$monitor("time = %t,fifo_in = %d,re = %b,we = %b,*********\n fifo_out = %d,overflow = %b,underflow = %b \n\n",
		$time,fifo_in,re, we, fifo_out, overflow, underflow);

	$dumpfile("fifo.vcd");
	$dumpvars(0,fifo_tb);
end

endmodule 
