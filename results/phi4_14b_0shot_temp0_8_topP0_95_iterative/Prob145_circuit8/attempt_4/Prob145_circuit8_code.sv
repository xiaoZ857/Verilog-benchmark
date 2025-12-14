
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
always @(posedge clock) begin
    if (a == 1'b0) begin
        p <= 1'b0;
        q <= 1'b0;
    end else begin
        p <= 1'b1;
        q <= 1'b1;
    end
end

always @(negedge clock) begin
    if (p == 1'b1 && q == 1'b0) begin
        // When falling edge, and p is 1 while q is 0, set q to 1.
        q <= 1'b1;  
    end else if (p == 1'b1 && q == 1'b1) begin
        // When both are 1 at a falling edge, maintain current state.
        // No action needed since we want no change here.
    end
end

endmodule
