
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
always @(posedge clock) begin
    if (a == 1'b0) begin
        // Reset both outputs to 0 if 'a' is 0 on rising edge.
        p <= 1'b0;
        q <= 1'b0;
    end else begin
        // Set both outputs to 1 if 'a' is 1 on rising edge.
        p <= 1'b1;
        q <= 1'b1;
    end
end

always @(negedge clock) begin
    if (p == 1'b1 && q == 1'b0) begin
        // Only reset 'p' to 0, but keep 'q' unchanged.
        p <= 1'b0;
    end else if (p == 1'b1 && q == 1'b1) begin
        // If both are 1, only reset 'p', not 'q'.
        p <= 1'b0;
    end
end

endmodule
