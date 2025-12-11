
module TopModule (
  input [7:0] in,
  output [31:0] out
);
 ```verilog
always @(posedge clk) begin
    reg [31:0] temp;
    assign temp[7] = in[7];
    always_comb begin
        for (int i = 6; i >= 0; i--)
            temp[i + 24] <= temp[i];
    end
    out = {temp, in};
end
endmodule

// VERILOG-EVAL: abnormal backticks count
