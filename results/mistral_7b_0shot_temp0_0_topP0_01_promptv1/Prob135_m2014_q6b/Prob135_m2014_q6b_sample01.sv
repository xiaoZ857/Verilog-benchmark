
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
 ```verilog
always @(posedge clk) begin
    case (y)
        000: Y2 <= w;
        001: Y2 <= w;
        010: Y2 <= w;
        011: Y2 <= !w;
        100: Y2 <= !w;
        101: Y2 <= w;
        default: Y2 <= 1'bx; // Unreachable state, set to 'x' for simulation purposes
    endcase
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
