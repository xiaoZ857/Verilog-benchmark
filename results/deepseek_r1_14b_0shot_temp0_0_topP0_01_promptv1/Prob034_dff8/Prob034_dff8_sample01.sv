
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
always @(posedge clk) begin
    for (i=0; i<8; i++) begin
        D <= d[i];
        q[i] <= D;
    end
end
endmodule
