
module TopModule (
  input wire clk,    // Clock input
  input wire d,      // Data input
  output reg q       // Output that stores the captured data
);

  always @(posedge clk) begin
    q <= d;           // Capture the value of `d` on the rising edge of `clk`
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
