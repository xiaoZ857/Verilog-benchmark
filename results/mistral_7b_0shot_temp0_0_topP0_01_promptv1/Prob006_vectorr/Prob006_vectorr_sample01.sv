
module TopModule (
  input [7:0] in,
  output [7:0] out
);
 ```verilog
always @(posedge clk) begin
    logic [7:0] temp;
    for (int i = 0; i < 8; i++)
        temp[i] = in[7-i];
    out = temp;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
