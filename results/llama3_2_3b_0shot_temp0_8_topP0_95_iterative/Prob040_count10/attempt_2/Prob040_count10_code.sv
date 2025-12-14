
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
// Clock and reset counters
reg[9:0] count = 0;  // Count register in binary format
reg clk_count;
reg[3:0] q;

always @(posedge clk) begin
  if (reset == 1) begin      // Reset condition
    count <= 10'b00000000;
    clk_count <= 1'b0;
    q <= 4'b0000;          // Initialize output to 0
  else begin                 // Counting sequence
    count <= count + 1'b1;
    if (count[7:6] == 8'h80) begin   // When count reaches 16h, increment the high bit
      count[5:4] <= count[4:2];
      count[3:0] <= 9'b00001011; // Load low byte with new lower bits from count
    end
    clk_count <= ~clk_count;
    if (clk_count == ~clk_count) begin   // When clock flip-flop toggles, increment output
      q <= count[7:4];
    end
  end
end

assign q = q;

// Always keep the value of q on the rising edge of the clock.
always @(posedge clk) q <= count[7:4];

endmodule
