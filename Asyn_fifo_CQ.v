`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:44 07/08/2017 
// Design Name: 
// Module Name:    Asyn_fifo_CQ 
// Project Name: 	 Asynchronous FIFO buffer using Circular Queue based implementation
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Asyn_fifo_CQ(data_out,mem_full,mem_empty,data_in,rst,rclk,wclk,r_en,w_en);
	parameter data_width = 4;
	parameter mem_width = 3;
	parameter ptr_count = 2;
	
	input rclk;
	input wclk;
	input r_en;
	input w_en;
	input rst;
	input [data_width-1:0] data_in;
	
	output reg [data_width-1:0] data_out;
	output reg mem_full;
	output reg mem_empty;
	
	reg [data_width-1:0]mem[0:mem_width-1];
	reg [ptr_count-1:0] front;
	reg [ptr_count-1:0] rear;
	
	initial begin
	front <= 0;
	rear <= 0;
	end
	
	always @(posedge wclk)begin
	if(rst)begin
		mem_full<=1'b0;
		rear<=0;
	end
	else if(w_en)begin
		if((rear == mem_width-1)&&(front == 0) || (rear == front-1))begin
			mem_full <= 1'b1;
		end
		else begin
			mem[rear] <= data_in;
			if(rear == mem_width-1)begin
				rear <= 0;
			end
			else begin
				rear <= (rear + 2'b1);
			end
			mem_full <= 1'b0;
		end	
	end
	end
	
	always @(posedge rclk)begin
	if(rst)begin
		mem_empty<=1'b0;
		front<=0;
	end
	else if(r_en)begin
		if(front==0 && rear==0)begin
			mem_empty <= 1'b1;
		end
		else begin
			data_out <= mem[front];
			if(front == mem_width-1)begin
				front <= 0;
			end
			else begin 
				front <= (front+2'b1);
			end
			mem_empty <= 1'b0;
		end
	end
	end
	
endmodule

module GrayCode_Counter(q,rst,clk);
	parameter n=3;
	input rst;
	input clk;
	output reg [n-1:0]q;
	reg [n-1:0]temp;
	initial begin
	q<=3'b000;
	temp<=3'b000;
	end
	always @(posedge clk)begin
		if(!rst)begin
			q[0] <= temp[1]^temp[0];
			q[1] <= temp[2]^temp[1];
			q[2] <= temp[2];
			temp <= temp + 3'b001;
		end
		else begin
			q<=3'b000;
		end
	end
endmodule
