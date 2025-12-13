
// timescale should be at the top of the file, not inside a module
`timescale 1ns / 1ps

module TopModule (
  input a,
  input b,
  input sel,
  output out
);

always_comb begin
  if (sel == 0) begin
    out = a;
  end else begin
    out = b;
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
