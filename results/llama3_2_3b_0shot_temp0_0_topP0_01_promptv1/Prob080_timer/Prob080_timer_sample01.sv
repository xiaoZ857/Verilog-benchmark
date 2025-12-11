
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
assign tc = !count;
always @(posedge clk) begin
    if (load)
        count <= data;
    else
        count <= count - 1'b1;
endmodule
