

module TopModule (
  input a,
  input b,
  input sel,
  output out
);

always @(posedge clk) begin
    if (sel == 0)
        out <= a;
    else
        out <= b;
end

// VERILOG-EVAL: endmodule not found
