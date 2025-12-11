
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
 ```verilog
reg [3:0] data;
always @(posedge clk) begin
    if (!resetn)
        data <= 4'b0;
    else
        data <= {data[3:1], in, data[0]};
end
assign out = data[3];
endmodule

// VERILOG-EVAL: abnormal backticks count
