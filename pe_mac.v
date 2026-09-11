`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Jammu
// Engineer: Susmita Ghanta
// 
// Create Date: 09/12/2025 01:21:38 AM
// Design Name: 
// Module Name: pe_mac
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
///////////////////////////////////////////////////////////////////////////////
module pe_mac #(

    parameter AW = 16,
    parameter BW = 16,
    parameter CW = 32
)(
    input wire clk,
    input wire rst,
    input wire vld_in,

    input wire signed [AW-1:0] a_in,
    input wire signed [BW-1:0] b_in,

    output reg signed [AW-1:0] a_out,
    output reg signed [BW-1:0] b_out,
    output reg signed [CW-1:0] acc_out
);

    always @(posedge clk) begin

        if (rst) begin
            a_out   <= {AW{1'b0}};
            b_out   <= {BW{1'b0}};
            acc_out <= {CW{1'b0}};
        end

        else if (vld_in) begin

            // Pass A to the right
            a_out <= a_in;

            // Pass B downward
            b_out <= b_in;

            // Local MAC operation
            acc_out <= acc_out +
                       ($signed(a_in) * $signed(b_in));

        end

    end

endmodule
