
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
always @(posedge clk or negedge areset) begin
  if (areset) begin
    A <= 1'b0; // reset to state B
    B <= 1'b1;
  end else if (A == B) begin
    // hold current state A
    A <= A;
  end else if (A == 1'b0 && in == 1'b0) begin
    // transition from state A to state B
    A <= 1'b1;
    B <= A;
  end else if (A == 1'b1 && in == 1'b1) begin
    // hold current state B
    B <= B;
  end else if (A == 1'b0 && in == 1'b1) begin
    // transition from state B to state A
    A <= 1'b0;
    B <= A;
  end else if (A == 1'b1 && in == 1'b0) begin
    // hold current state A
    A <= A;
  end
end

assign out = B;

// VERILOG-EVAL: endmodule not found
