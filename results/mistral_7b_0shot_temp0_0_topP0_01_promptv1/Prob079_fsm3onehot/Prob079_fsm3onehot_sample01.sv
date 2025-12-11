
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
 ```verilog
always @(posedge clk) begin
    case (state)
        4'b0001: // A state
            if (in === 0)
                next_state <= 4'b0001;
            else
                next_state <= 4'b0010;
        // Add cases for B, C, and D states following the same pattern
    endcase
end

assign out = (state === 4'b0010) || (next_state === 4'b0010);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
