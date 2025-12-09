

module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

reg [15:0] q[16:1];

always @(posedge clk) begin
  if (!resetn) begin
    for (int i = 16; i >= 2; i--) 
      q[i] <= 1'b0;
  end else begin
    for (int i = 16; i >= 2; i--) 
      q[i] <= d[i];
  end
end

assign q[1] = byteena[0] ? d[7:0] : q[2];

for (int i = 8; i < 16; i++) 
  assign q[i] = byteena[1] ? d[i+8:15] : q[i+8];
endmodule
