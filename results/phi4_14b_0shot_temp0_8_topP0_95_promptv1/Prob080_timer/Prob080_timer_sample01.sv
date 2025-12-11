
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
logic [9:0] counter;
assign tc = (counter == 10'b0);

always @(posedge clk) begin
    if (load)
        counter <= data;
    else if (counter != 10'b0)
        counter <= counter - 1;
end
endmodule
