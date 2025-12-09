
module TopModule (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

always @(posedge clock) begin
  if (a) begin
    p <= !p;
    q <= !q;
  end else begin
    p <= ~p & ~q;
    q <= p;
  end
end

always @* begin
  if (!a && p == 1'b0 && q == 1'b0) begin
    p <= 1'b1;
    q <= 1'b1;
  end
end

initial begin
  #5 (a = 0);
  #25 (a = 1);
  #85 (a = 0);
  #115 (a = 1);
  #145 (a = 0);
  #175 (a = 1);
  #205 (a = 0);
end

initial begin
  repeat(10) #1;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
