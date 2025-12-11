
module TopModule (
  input [7:0] in,
  output parity
);
 ```verilog
reg [7:0] tmp;
assign parity = xor(in[7]);
always @(posedge clk) begin
    tmp = in;
    for (int i = 1; i < 8; i = i + 1) begin
        tmp[i] ^= tmp[i-1];
    end
    assign parity = tmp[7];
end
endmodule

// VERILOG-EVAL: abnormal backticks count
