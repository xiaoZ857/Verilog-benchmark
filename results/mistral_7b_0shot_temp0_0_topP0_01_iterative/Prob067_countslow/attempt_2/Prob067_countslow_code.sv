
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0001; // Reset the counter to 0
  end else if (!slowena || q == 4'b0000) begin
    // If slowena is low or the counter is at 0, do not increment
  end else begin
    q <= q + 1; // Increment the counter when slowena is high and counter is not at 0
  end
end

always @(posedge clk) begin
  if (q >= 10'b10010) begin // Decade rollover
    q <= 4'b0001; // Reset the counter to 0
  end
end

assign q[3] = (q >= 4'b0101) && (q < 4'b1000);
assign q[2] = (q >= 4'b0100) && (q < 4'b0101);
assign q[1] = (q >= 4'b0010) && (q < 4'b0100);
assign q[0] = (q >= 4'b0001) && (q < 4'b0010);

endmodule
