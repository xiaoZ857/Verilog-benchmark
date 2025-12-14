
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
always @ (sel or a or b)
begin
    if (~sel)
        out <= a;
    else
        out <= b;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
