
module TopModule (
  input clk,
  input a,
  output reg q
);
always @(posedge clk) begin
    if (a)
        q <= ~q; // toggle 'q' when 'a' is high
    else
        q <= q; // otherwise, leave 'q' unchanged
end

// Add timescale directive after the module definition
`timescale 1ns / 1ps

// Add timespec directives for simulation waveform comparison
initial begin
    #5 clk = 1; a = 0; // time 5ns, clk = 1, a = 0
    #10 clk = 0; // time 10ns, clk = 0
    #15 clk = 1; a = 0; // time 15ns, clk = 1, a = 0
    #20 clk = 0; // time 20ns, clk = 0
    #25 clk = 1; a = 0; // time 25ns, clk = 1, a = 0
    // ... continue with the rest of the waveform values
    // ... and ensure that the last line is #90 clk = 0; // time 90ns, clk = 0
end

// VERILOG-EVAL: endmodule not found
