
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(negedge clk or posedge reset) begin
  if (reset)
    q <= 8'b0110_0100; // Setting initial value to 0x34
  else
    q <= d; // Assigning the value of 'd' when reset is not active
end

assign q[7] = !q[7]; // Inverting the most significant bit (MSB) for active high reset

endmodule
