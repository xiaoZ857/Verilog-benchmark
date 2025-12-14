
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(posedge clk or negedge clk)
begin
    if (reset)
        q <= 8'b10100100; // Initializing the flip-flops with 0x34
    else if (negedge clk)
        q <= d; // Assigning input `d` to output `q` on the negative edge of clock
end

// Ensure that reset has a high impedance state (Z) when it's not asserted
assign reset = 1'bz when (reset != 1'b0); // Changed from 'reset!=1'b1' to 'reset!=1'b0' for active high reset

endmodule
