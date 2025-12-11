
module TopModule (
  input clk,
  input in,
  output logic out
);
assign out = a & b;

always @(posedge clk) begin
    if (reset)
        q <= 1'b0;
    else
        q <= d;
end

assign q = !in | out; // Using always_comb for combinatorial logic

// VERILOG-EVAL: endmodule not found
