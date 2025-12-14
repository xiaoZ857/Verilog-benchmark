
module TopModule (
  input clk,
  input a,
  output reg q
);

always @(posedge clk) begin
    if (a)
        q <= ~q; // toggle 'q' when 'a' is high
    else
        q <= q; // otherwise, leave 'q' unchanged
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
