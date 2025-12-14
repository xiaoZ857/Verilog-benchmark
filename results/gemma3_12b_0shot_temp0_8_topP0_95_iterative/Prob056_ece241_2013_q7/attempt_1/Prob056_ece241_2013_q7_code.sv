
module TopModule (
  input clk,
  input j,
  input k,
  output reg Q
);

  always @(posedge clk) begin
    if (j == 0 && k == 0) begin
      Q <= Q;  // No change, retain previous value
    end else if (j == 0 && k == 1) begin
      Q <= 0;  // Reset to 0
    end else if (j == 1 && k == 0) begin
      Q <= 1;  // Set to 1
    end else if (j == 1 && k == 1) begin
      Q <= ~Q; // Toggle
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
