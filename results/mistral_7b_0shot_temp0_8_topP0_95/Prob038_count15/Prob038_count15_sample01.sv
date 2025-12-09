
module TopModule (
  input wire clk,
  input wire reset,
  output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0001; // Reset the counter to 0
  end else begin
    if (q < 16'hFF) begin
      q <= q + 1; // Increment the counter
    end
  end
end

// For synthesis purposes, include this constraint for synchronous reset:
initial begin
  $syncreset(TopModule)(clk, reset);
end

// To test the module, you can use an initial block as follows:
// initial begin
//   clk = 0;
//   #5 clk = !clk; // Toggle clock every 5 time units for testing
//   #200 $finish; // Simulation stops after 200 time units
// end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
