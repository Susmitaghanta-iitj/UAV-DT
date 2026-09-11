`timescale 1ns / 1ps

module swissh8_tb;
  reg [11:0] xn;

  // Outputs
  wire [11:0] f1_xn;
  wire [11:0] exp_out;

  // Internal wires for intermediate values
  wire [11:0] sum1, sum2, div_out, mult_out;

  // Instantiate the Unit Under Test (UUT)
  swissh8 uut (
    .xn(xn),
    .f1_xn(f1_xn),
    .exp_out(exp_out),
    .sum1(sum1),
    .sum2(sum2),
    .div_out(div_out),
    .mult_out(mult_out)
  );

  initial begin
    // Display header
    

   
    // Test Case 3: xn = 2.0 => 2.0 * 128 = 256
    xn = 12'd256;
    #10;
    $display("%4t | %d | %d | %d | %d | %d | %d", $time, xn, sum1, exp_out, sum2, div_out, f1_xn);

    
    // End simulation
    $finish;
  end

endmodule

