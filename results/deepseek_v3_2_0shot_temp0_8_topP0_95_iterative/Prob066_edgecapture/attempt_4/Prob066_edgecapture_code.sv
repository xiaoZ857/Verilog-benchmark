
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
reg [31:0] prev_in;

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
        prev_in <= 32'b0;
    end else begin
        // Store current input for next cycle's comparison
        prev_in <= in;
        
        // For each bit: if we had 1 last cycle and 0 this cycle, set output bit to 1
        // Once set, it stays 1 (OR with current out)
        out <= out | (prev_in & ~in);
    end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
