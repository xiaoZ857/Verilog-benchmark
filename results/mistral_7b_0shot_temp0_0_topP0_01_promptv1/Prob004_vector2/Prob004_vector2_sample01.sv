
module TopModule (
  input [31:0] in,
  output [31:0] out
);
 ```verilog
always @(posedge clk) begin
    reg [31:0] temp [3:0];
    for (int i = 0; i < 4; i++) begin
        temp[i] = in[8*i + 3];
    end
    out = {temp[3], temp[2], temp[1], temp[0]};
end
endmodule

// VERILOG-EVAL: abnormal backticks count
