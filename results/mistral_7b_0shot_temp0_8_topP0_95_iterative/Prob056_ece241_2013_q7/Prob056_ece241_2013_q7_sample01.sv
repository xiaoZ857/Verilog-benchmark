
module TopModule (
  input clk,
  input j,
  input k,
  output reg Q,
  output reg Qold // Adding Qold output
);

always @(posedge clk) begin
  if ((j == 1'b0) && (k == 1'b0)) begin
    Q <= Qold; // Q stays the same on synchronous reset
  end else if ((j == 1'b0) && (k == 1'b1)) begin
    Q <= 1'b0; // Q becomes 0 when K is set and J is reset
  end else if ((j == 1'b1) && (k == 1'b0)) begin
    Q <= 1'b1; // Q becomes 1 when J is set and K is reset
  end else begin // J & K are both set or both reset
    Q <= ~Qold; // Q toggles when both J and K are set or both reset
  end
end

assign Qold = Q; // Assign the new output value to the old output

endmodule

// VERILOG-EVAL: errant inclusion of module definition
