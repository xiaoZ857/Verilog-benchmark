
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
 ```verilog
always @(posedge clk) begin
    if (load)
        count <= data;
    else if (count > 0)
        count = count - 1;
end

assign tc = (count == 0);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
