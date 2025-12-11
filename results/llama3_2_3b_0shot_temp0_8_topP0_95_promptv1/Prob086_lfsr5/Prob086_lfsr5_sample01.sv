
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
assign q[0] = q[5] ^ q[3];
 
always @(posedge clk) begin
    assign q[1] = q[2] ^ q[5] ^ q[3];
end
 
always @(posedge clk) begin
    assign q[2] = q[4] ^ q[1] ^ q[3];
end
 
always @(posedge clk) begin
    assign q[3] = q[0] ^ q[1] ^ q[2];
end
 
assign q[4] = q[5];

endmodule
