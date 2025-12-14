
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
always @(posedge clock) begin
    p <= a & (~q);
end

always @(negedge clock) begin
    if (~q) begin
        q <= p;
    end else begin
        q <= ~a;
    end
end

// VERILOG-EVAL: endmodule not found
