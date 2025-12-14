
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
    if (shift_ena) begin
        // Shift operation has priority over counting
        q <= {q[2:0], data}; // Insert 'data' into LSB, shift everything else left
    end 
    else if (count_ena && !shift_ena) begin  // Ensure that we only count when not shifting
        // Decrement the current value stored in 'q'
        if (q != 4'b0000) begin
            q <= q - 1; // Simple decrement if not zero to avoid underflow
        end
    end
end

endmodule
