
module TopModule (
  input wire d,      // Data input
  input wire ena,    // Enable signal
  output reg q       // Output of the latch
);

  // Always block triggered on the positive edge or when enable changes
  always @(ena or posedge clk) begin
    if (ena) begin
      q <= d;  // Capture the value of 'd' at 'q' when 'ena' is high
    end
    else begin
      q <= q;  // Hold the current value of 'q'
    end
  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
