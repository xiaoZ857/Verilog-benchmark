
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
            end else if (out[i] == 0) begin
                // Only set output to '0' if it was not previously set by a transition
                out[i] <= in[i];
            end
        end

        // Update previous input state for next cycle
        prev_in <= in;
    end
endmodule
