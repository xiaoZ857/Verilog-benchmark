
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
  
  reg [255:0] next_q;
  integer i, j, ni, nj;
  integer neighbor_count;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      // Calculate next state for each cell
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          neighbor_count = 0;
          
          // Count all 8 neighbors
          for (ni = -1

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
