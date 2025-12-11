
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
genvar i;
for (i=0; i<8; i++) begin : dff_loop
    always @(posedge clk) begin
        q[i] <= d[i];
    end
end
endmodule
