

module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);

always @(posedge clk) begin
    if (reset == 1) begin
        q <= 4'b0000;
    end else begin
        if (~((q == 4'b1001))) begin // If not at 9
            q <= q + 1;              // Increment counter
        end else begin
            q <= 4'b0000;           // Reset to 0 after reaching 9
        end
    end
end

// VERILOG-EVAL: endmodule not found
