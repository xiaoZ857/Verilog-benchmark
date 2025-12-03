

module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);

 ```verilog
reg [9:0] counter;
always @(posedge clk) begin
    if (load)
        counter <= data;
    else if (counter > 0)
        counter = counter - 1;
end

assign tc = (counter == 0);

endmodule

// VERILOG-EVAL: abnormal backticks count
