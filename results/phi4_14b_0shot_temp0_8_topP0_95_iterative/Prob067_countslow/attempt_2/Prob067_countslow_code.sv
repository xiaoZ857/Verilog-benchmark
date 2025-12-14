
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q // 4-bit output for counting from 0 to 9
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous active-high reset
        q <= 4'b0000;
    end else if (slowena) begin
        // Increment the counter only when slowena is high
        if (q == 4'b1001) begin
            // Reset to 0 after reaching 9
            q <= 4'b0000;
        end else begin
            // Normal increment operation
            q <= q + 1;
        end
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
