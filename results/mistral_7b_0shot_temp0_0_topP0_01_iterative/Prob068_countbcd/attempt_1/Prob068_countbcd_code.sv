
module TopModule (
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0000; // Reset all digits to zero
    ena <= 3'b000; // All enable signals are off
  end else begin
    // Increment each digit from the least significant one
    q[15:12] <= q[15:12] + 1;
    if (q[12] == 10) begin
      q[12] <= 4'b0000; // Reset tens digit if it overflows
      ena[1] <= ~ena[1]; // Toggle enable signal for tens digit
    end

    q[15:13] <= q[15:13] + (ena[1]); // Increment hundreds and thousands digits with enable signal
    if (q[15] == 10) begin
      q[15] <= 4'b0000; // Reset thousands digit if it overflows
      ena[2] <= ~ena[2]; // Toggle enable signal for thousands digit
    end

    if (q[12] == 9) begin
      q[13:10] <= q[13:10] + 1; // Increment tens, hundreds and thousands digits when tens digit is 9
      ena[0] <= ~ena[0]; // Toggle enable signal for ones digit
    end
  end
end

// Ensure that the output signals are synchronized with the clock
always @(posedge clk) begin
  q <= {q[15:4], q[7:0]}; // Swap the order of digits to match the output description
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
