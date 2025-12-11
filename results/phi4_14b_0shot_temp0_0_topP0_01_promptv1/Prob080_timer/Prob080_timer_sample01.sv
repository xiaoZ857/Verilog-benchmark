
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
logic [9:0] count;
assign tc = (count == 10'b0);

always @(posedge clk) begin
    if (load)
        count <= data;
    else if (count != 10'b0)
        count <= count - 1;
end
endmodule
