
module TopModule (
  input wire clk,
  input wire reset,
  output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0000; // Reset the counter to 0
  end else begin
    if (q < 16'b1111) begin
      q <= q + 1; // Increment the counter
    end
  end
end

// Alternatively, you can use a loop for counting up to 15:
// always @(posedge clk or posedge reset) begin
//   if (reset) begin
//     q <= 4'b0000; // Reset the counter to 0
//   end else begin
//     if (q == 4'b0000) begin
//       q <= 4'b0001; // Increment the first bit
//     end else begin
//       for (int i = 3; i >= 0; i--) begin
//         if (q[i] == 1) begin
//           q[i] <= 0; // Reset the current bit
//           q <= q << 1 | 1'b1; // Shift all other bits left and set the next bit to 1
//           break;
//         end
//       end
//     end
//   end
// end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
