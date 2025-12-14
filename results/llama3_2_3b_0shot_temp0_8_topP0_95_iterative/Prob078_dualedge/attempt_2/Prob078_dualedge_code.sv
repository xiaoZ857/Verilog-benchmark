
module TopModule (
  input clk,
  input d,
  output reg q
);

reg prev_q;

always @(posedge clk) begin
    if (d == 1'0)
        prev_q <= ~q;
    else
        prev_q <= q;
end

always @(posedge clk or negedge clk) begin
    q <= (~prev_q & d);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
