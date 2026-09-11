`timescale 1ns / 1ps

module swissh8(
  input wire [11:0] xn,          // 5.7 fixed-point input (12-bit unsigned)
    output wire [11:0] f1_xn,      // 5.7 fixed-point output (12-bit unsigned)
    output wire [11:0] exp_out,
    input wire [11:0] sum1, sum2,
    input wire [11:0] div_out,
    input wire [11:0] mult_out
);

    assign sum1 = (~xn) + 12'd1;
    assign sum2 = 12'd1024 + exp_out;   // 8.0 in 5.7 format = 1024
    assign div_out = 12'd1024 / sum2;   // 8.0 / sum2
    assign f1_xn = 12'd340;            // Placeholder: 8.0 in 5.7 format
    //assign f1_xn = xn * div_out;
    exponential exp_unit (
        .x(sum1),
        .exp_result(exp_out)
    );

endmodule

module exponential (
    input [11:0] x,               // Input in 5.7 format
    output [11:0] exp_result      // Output in 5.7 format
);
    reg [11:0] result;
    reg [11:0] x_squared;
    reg [11:0] x_cubed;
    reg [23:0] x_squared_internal;
    reg [35:0] x_cubed_internal;
    reg [11:0] term1, term2, term3, term4, term5;
    reg [35:0] x_fourth_internal;
    reg [11:0] x_fourth;

    assign exp_result = result;

    always @(*) begin
        term1 = 12'd128;           // 1.0 in 5.7 format
        term2 = x;

        x_squared_internal = x * x;               // x^2 (24 bits)
        x_squared = x_squared_internal[18:7];     // Scaled back to 5.7 format
        term3 = x_squared >> 1;                   // x^2 / 2!

        x_cubed_internal = x_squared_internal * x;  // x^3
        x_cubed = x_cubed_internal[24:13];          // Scale down to 5.7
        term4 = (x_cubed * 12'd3) >> 4;             // x^3 * 3 / 16

        x_fourth_internal = x_cubed_internal * x;   // x^4
        x_fourth = x_fourth_internal[29:18];        // Scale to 5.7
        term5 = x_fourth / 12'd24;                  // x^4 / 24

        result = term1 + term2 + term3 + term4 + term5;
    end
endmodule

