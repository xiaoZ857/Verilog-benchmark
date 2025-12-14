
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

always @(posedge clk) begin
  if (reset) begin
    state <= A;
    z <= 0;
    count <= 0;
    w_count <= 0;
  end else begin
    case (state)
      A: begin
        z <= 0;
        if (s) begin
          state <= B;
          count <= 0;
          w_count <= 0;
        end
      end
      
      B: begin
        // Count w=1

// VERILOG-EVAL: endmodule not found
