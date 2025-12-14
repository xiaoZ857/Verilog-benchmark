
// Define a module that counts from 0 through 9, inclusive, with a period of 10.
module TopModule (
  input clk,         // Positive clock signal
  input reset,        // Reset active high synchronous input
  output reg [3:0] q   // Counter output in decimal format
);

// Clock and reset counters
reg[1:0][9:0] count = 0;  // Count register in binary format
reg clk_count;
reg[3:0] q;

always @(posedge clk) begin
  if (reset == 1) begin      // Reset condition
    count <= 10'b00000000;
    clk_count <= 1'b0;
    q <= 4'b0000;          // Initialize output to 0
  else begin                 // Counting sequence
    count <= count + 1'b1;
    if (count[9:5] == 16'h100) begin   // When count reaches 16h, increment the high bit
      count[4:0] <= count[3:2];
      count[2:0] <= 3'b001;        // Load low byte with new lower bits from count
    end
    clk_count <= ~clk_count;
    if (clk_count == ~clk_count) begin   // When clock flip-flop toggles, increment output
      q <= count[4:1];
    end
  end
end

// Assign output to q
assign q = q;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
