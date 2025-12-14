
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
    if (a == 1'b0) begin
        // Check if q is about to roll over from 7
        if (q == 3'b111) begin
            q <= 3'b000; // Reset to 0 when q reaches 7
        end else begin
            q <= q + 1'b1; // Increment q otherwise
        end
    end
end


// VERILOG-EVAL: endmodule not found
