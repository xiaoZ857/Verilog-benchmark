
module TopModule (
  input [2:0] in,
  output [1:0] out
);
 ```verilog
reg [1:0] internal_count;
assign out[0] = internal_count[0];
assign out[1] = internal_count[1];

always @(posedge clk) begin
    internal_count[0] <= in[0] + internal_count[1];
    internal_count[1] <= in[1] + in[2] + internal_count[0];
end

endmodule

// VERILOG-EVAL: abnormal backticks count
