
module TopModule (
  input [99:0] in,
  output reg [99:0] out
);
 ```verilog
always @(posedge clk) begin
    int i;
    logic [99:0] temp;

    for (i = 0; i < 100; i++) begin
        temp[i] = in[99-i];
    end
    out = temp;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
