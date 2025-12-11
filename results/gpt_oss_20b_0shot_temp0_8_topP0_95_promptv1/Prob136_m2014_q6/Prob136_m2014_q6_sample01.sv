
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
always @(posedge clk) begin
    if (reset)
        state <= 3'd0; // go to state A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        3'd0: next_state = w ? 3'd0 : 3'd1; // A: w=0 -> B, w=1 -> A
        3'd1: next_state = w ? 3'd3 : 3'd2; // B: w=0 -> C, w=1 -> D
        3'd2: next_state = w ? 3'd3 : 3'd4; // C: w=0 -> E,

// VERILOG-EVAL: endmodule not found
