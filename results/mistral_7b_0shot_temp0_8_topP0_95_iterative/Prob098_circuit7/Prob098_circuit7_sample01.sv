
module TopModule (
  input clk,
  input a,
  output reg q
);
`timescale 1ns / 1ps

always @(posedge clk) begin
    if (a)
        q <= ~q; // toggle 'q' when 'a' is high
    else
        q <= q; // otherwise, leave 'q' unchanged
end

// Add timespec directives for simulation waveform comparison inside the test bench module
module Prob098_circuit7_test();
  reg clk, a;
  wire q;
  TopModule uut (.clk(clk), .a(a), .q(q));

  // Your given simulation waveforms for the circuit output 'q'
  initial begin
    clk = 0; a = 0; // time 0ns, clk = 0, a = 0
    #5 clk = 1; a = 0; // time 5ns, clk = 1, a = 0
    #10 clk = 0; // time 10ns, clk = 0
    #15 clk = 1; a = 0; // time 15ns, clk = 1, a = 0
    #20 clk = 0; // time 20ns, clk = 0
    #25 clk = 1; a = 0; // time 25ns, clk = 1, a = 0
    #30 clk = 0; // time 30ns, clk = 0
    #35 clk = 1; a = 1; // time 35ns, clk = 1, a = 1
    #40 clk = 0; // time 40ns, clk = 0
    #45 clk = 1; a = 1; // time 45ns, clk = 1, a = 1
    #50 clk = 0; // time 50ns, clk = 0
    #55 clk = 1; a = 1; // time 55ns, clk = 1, a = 1
    #60 clk = 0; // time 60ns, clk = 0
    #65 clk = 1; a = 1; // time 65ns, clk = 1, a = 1
    #70 clk = 0; // time 70ns, clk = 0
    #75 clk = 1; a = 1; // time 75ns, clk = 1, a = 1
    #80 clk = 0; // time 80ns, clk = 0
    #85 clk = 1; a = 1; // time 85ns, clk = 1, a = 1
    #90 clk = 0; // time 90ns, clk = 0
  end
endmodule

// Reference model for comparison (optional)
module Prob098_circuit7_ref(
  input clk,
  input a,
  output reg q
);

// Your implementation of the circuit goes here. I'm assuming it should be the same as the TopModule definition provided earlier.

endmodule
