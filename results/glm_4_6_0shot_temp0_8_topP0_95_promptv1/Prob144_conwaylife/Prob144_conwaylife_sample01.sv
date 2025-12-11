
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [255:0] next_q;
  integer i, j;
  integer row, col;
  integer neighbor_count;
  integer neighbor_row, neighbor_col;
  integer neighbor_idx;
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end
  
  always @(*) begin
    for (i = 0; i < 256; i = i + 1) begin
      row = i / 16;
      col = i % 16;
      neighbor_count = 0;
      
      // Check all 8 neighbors
      for (j = -1; j <= 1; j = j + 1) begin
        for (integer k = -1; k <= 1; k = k + 1) begin
          if (j != 0 || k != 0) begin
            neighbor_row = (row + j + 16) % 16;
            neighbor_col = (col + k + 16) % 16;
            neighbor_idx = neighbor_row * 16 + neighbor_col;
            neighbor_count = neighbor_count + q[neighbor_idx];
          end
        end
      end
      
      // Apply Game of Life rules
      if (neighbor_count <= 1) begin
        next_q[i] = 1'b0;
      end else if (neighbor_count == 2) begin
        next_q[i] = q[i];
      end else if (neighbor_count == 3) begin
        next_q[i] = 1'b1;
      end else begin
        next_q[i] = 1'b0;
      end
   

// VERILOG-EVAL: endmodule not found
