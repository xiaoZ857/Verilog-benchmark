
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
assign tc = !counter;
always @(posedge clk)
    if (load)
        counter <= data;
    else
        counter <= counter - 1;

always @(posedge clk or reset)
    if (counter == 0)
        tc <= 1'b1;
endmodule
