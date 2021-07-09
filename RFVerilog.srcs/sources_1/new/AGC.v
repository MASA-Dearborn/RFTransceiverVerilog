`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2021 04:27:46 PM
// Design Name: 
// Module Name: AGC
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


module AGC(
    i_clk,
    i_rst,
    i_signalReal,
    i_signalImag,
    o_mag
    );
    
    input                i_clk;
    input                i_rst;   
    input  signed [15:0] i_signalReal; //Q1.15
    input  signed [15:0] i_signalImag; //Q1.15
    output signed [15:0] o_mag;        //Q2.14
    
    wire   signed [31:0] realTemp;     //Q2.30
    wire   signed [31:0] imagTemp;     //Q2.30
    wire   signed [15:0] magTemp;      //Q2.14
    reg    signed [15:0] magFinal;     //Q2.14
    
    assign realTemp = (i_signalReal*i_signalReal);
    assign imagTemp = (i_signalImag*i_signalImag);
    assign magTemp = realTemp[31:16] + imagTemp[31:16];
    //parameter [15:0] GAIN = 66;
    //parameter [15:0] REF_PWR = 819;
        
    always @(posedge i_clk)
      begin
      if(i_rst)
          begin
              magFinal <= 16'h0;
          end
      else
          begin
              magFinal <= magTemp[15:0];
          end
      end
    
    assign o_mag = magFinal;
endmodule
