
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous reset: clear the output and previous input state
        out <= 32'b0;
        prev_in <= 32'b0;
    end else begin
        for (int i = 0; i < 32; i++) begin
            if (prev_in[i] == 1 && in[i] == 0) begin
                // Capture the transition from '1' to '0'
                out[i] <= 1'b1;
            end else if (out[i] == 1) begin
                // Retain the output as '1' unless reset
                out[i] <= 1'b1;
            end else begin
                // Otherwise, set the output to '0'
                out[i] <= 1'b0;
            end
        end

        // Update previous input state for next cycle
        prev_in <= in;
    end
endmodule
