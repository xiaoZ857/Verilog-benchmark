
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
always @(posedge clk or posedge reset) begin
    if (reset)
        out <= 32'b0;
    else
        for (int i = 0; i < 32; i++) begin
            if (in[i] == 1'b0 && ^(in >> i)[0] == 1'b1)
                out[i] <= 1'b1;
            else
                out[i] <= out[i];
        end
end
endmodule
