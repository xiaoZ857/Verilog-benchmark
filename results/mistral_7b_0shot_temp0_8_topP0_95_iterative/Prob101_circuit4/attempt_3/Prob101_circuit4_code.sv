
always @(posedge clk) begin
  if ((a || b || c || d) && !q) begin
    q <= 1'b1;
  end
end

initial begin
  clk = 0;
  #5 clk = 1;
end

`timescale 1ns / 1ps

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

// The ref.sv file should have the simulation testbench for this module

endmodule // End of module declaration

// VERILOG-EVAL: errant inclusion of module definition
