
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

always @(posedge clock) begin
  if (a) begin
    // Transition to state [p=1, q=1]
    p <= !p;
    q <= !q;
  end else begin
    // Remain in state [p=0, q=0]
    p <= 0;
    q <= 0;
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
