

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
    end else if (clock == 1'b1 && a == 1'b1) begin
        p <= 1'b1;
        q <= 1'b0;
    end else if (p == 1'b1 && q == 1'b0) begin
        q <= 1'b1;
    end else if (q == 1'b1) begin
        p <= 1'b0;
    end
end

always @(negedge clock) begin
    if (a == 1'b1) begin
        p <= 1'b1;
        q <= 1'b1;
    end
end

endmodule
