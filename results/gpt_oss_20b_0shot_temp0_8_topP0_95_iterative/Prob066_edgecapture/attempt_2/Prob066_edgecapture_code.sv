
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
    // Register to hold the previous value of the input vector
    reg [31:0] prev_in;

    // Initialize registers for simulation (unknowns are avoided)
    initial begin
        out     = 32'b0;
        prev_in = 32'b0;
    end

    always @(posedge clk) begin
        if (reset) begin
            out     <= 32'b0;   // clear all bits
            prev_in <= 32'b0;   // reset previous value
        end else begin
            // Detect falling edges: previous = 1, current = 0
            out     <= out | (prev_in & ~in);
            prev_in <= in;      // store current input for next cycle
        end
    end
endmodule
