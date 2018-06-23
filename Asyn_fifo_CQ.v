`timescale 1ns/1ps

module fifo(
		fifo_out,
		overflow,
		underflow,
		fifo_in,
		re,
		we,
		clk,
		rst,
);

parameter data_width = 4;
parameter addr_width = 4;

input [data_width - 1:0] fifo_in;
input re;
input we;
input clk;
input rst;

output reg [data_width - 1:0] fifo_out;
output reg overflow;
output reg underflow;

reg [data_width - 1:0] fifo_memory [0:addr_width - 1];

integer inPtr; 
integer outPtr;

always @(posedge clk) begin
	if(rst) begin
		overflow <= 0;
		underflow <= 0;
		inPtr <= 0;
		outPtr <= 0;
	end
end

always @(posedge clk) begin
	if(re) begin
		if(outPtr == ((inPtr + 1) % addr_width)) begin
			$display("FIFO is full");
			overflow <= 1'b1;
		end
		else begin
			fifo_memory[inPtr] <= fifo_in;
			inPtr <= (inPtr + 1)%(addr_width);
			overflow <= 1'b0;
			$display("Inserted at : %d",inPtr);
			underflow <= 1'b0;			
		end
		$display("\n");	
	end
end

always @(posedge clk) begin
	if(we) begin
		if ((inPtr == outPtr)) begin
			$display("FIFO is Empty");
			underflow <= 1'b1;
		end
		else begin
			fifo_out <= fifo_memory[outPtr];
			outPtr <= (outPtr + 1)%(addr_width);
			$display("Element is : %d",fifo_out);
			overflow <= 1'b0; 
		end
		$display("\n");	
	end
end

endmodule
