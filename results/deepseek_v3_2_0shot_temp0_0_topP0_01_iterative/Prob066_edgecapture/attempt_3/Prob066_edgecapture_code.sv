
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
        prev_in <= in;
        
        // For each bit: if we've already captured a falling edge, keep output as 1
        // Otherwise, check if we have a falling edge now
        out <= out | (prev_in & ~in);
    end
end

endmodule

// VERILOG-EVAL: abnormal backticks count
