`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Jammu
// Engineer: Susmita Ghanta
// 
// Create Date: 09/12/2025 01:17:02 AM
// Design Name: 
// Module Name: systolicarray
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


module systolicarray#(

    parameter N  = 4,
    parameter AW = 16,
    parameter BW = 16,
    parameter CW = 32
)(
    input  wire                         clk,
    input  wire                         rst,
    input  wire                         vld_in,

    // Packed input bus for A
    // Total width = N * AW
    input wire signed [N*AW-1:0]        a_in,

    // Packed input bus for B
    // Total width = N * BW
    input wire signed [N*BW-1:0]        b_in,

    // Packed output bus for C
    // Total width = N*N*CW
    output wire signed [N*N*CW-1:0]     c_out
);


    // =========================================================
    // Internal A bus
    // A moves LEFT -> RIGHT
    // =========================================================

    wire signed [AW-1:0] a_bus [0:N][0:N-1];


    // =========================================================
    // Internal B bus
    // B moves TOP -> BOTTOM
    // =========================================================

    wire signed [BW-1:0] b_bus [0:N-1][0:N];


    // =========================================================
    // Internal accumulator bus
    // =========================================================

    wire signed [CW-1:0] acc_bus [0:N-1][0:N-1];


    genvar i;
    genvar j;


    // =========================================================
    // CONNECT INPUT A BUS
    // =========================================================

    generate

        for (i = 0; i < N; i = i + 1) begin : A_INPUT

            assign a_bus[0][i] =
                   a_in[(i+1)*AW-1 -: AW];

        end

    endgenerate


    // =========================================================
    // CONNECT INPUT B BUS
    // =========================================================

    generate

        for (j = 0; j < N; j = j + 1) begin : B_INPUT

            assign b_bus[0][j] =
                   b_in[(j+1)*BW-1 -: BW];

        end

    endgenerate


    // =========================================================
    // CREATE N x N PE ARRAY
    // =========================================================

    generate

        for (i = 0; i < N; i = i + 1) begin : ROW

            for (j = 0; j < N; j = j + 1) begin : COL


                pe_mac #(
                    .AW(AW),
                    .BW(BW),
                    .CW(CW)
                ) PE (

                    .clk(clk),
                    .rst(rst),
                    .vld_in(vld_in),

                    // A enters from LEFT
                    .a_in(a_bus[j][i]),

                    // B enters from TOP
                    .b_in(b_bus[i][j]),

                    // A moves RIGHT
                    .a_out(a_bus[j+1][i]),

                    // B moves DOWN
                    .b_out(b_bus[i][j+1]),

                    // Local accumulator
                    .acc_out(acc_bus[i][j])

                );


                // =================================================
                // PACK PE OUTPUT INTO c_out
                // =================================================

                assign c_out[
                    ((i*N+j+1)*CW)-1 -: CW
                ] = acc_bus[i][j];


            end

        end

    endgenerate

endmodule
