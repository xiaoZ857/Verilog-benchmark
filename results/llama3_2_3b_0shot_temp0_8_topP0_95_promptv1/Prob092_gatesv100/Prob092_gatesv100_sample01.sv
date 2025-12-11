
module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
assign out_both = (in[99] & in[98]) ? 1'b1 : 1'b0;
assign out_any[1:0] = {in[2], in[1]};
assign out_any[99:2] = (in[99] | in[100]) ? {1'b1, 1'b0} : {1'b0, 1'b0};
assign out_different[98:0] = {in[99]^in[98], in[98]^in[97]};

assign out_any[98:1] = (in[98] | in[99]);
assign out_diff[99:0] = {in[100]^in[99], in[99]^in[98]};

always @(posedge clk) begin
  assign out_different[0] = in[99]^in[0];
end

// VERILOG-EVAL: endmodule not found
