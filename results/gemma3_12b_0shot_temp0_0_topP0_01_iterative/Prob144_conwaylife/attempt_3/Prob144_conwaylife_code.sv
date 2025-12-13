
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
  reg [255:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end

  always @(*) begin
    next_q = q;
    for (int i = 0; i < 256; i++) begin
      int row = i / 16;
      int col = i % 16;

      int neighbors = 0;

      // Calculate neighbors, wrapping around the grid
      for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
          if (dr == 0 && dc == 0) continue; // Skip the cell itself

          int neighbor_row = (row + dr + 16) % 16;
          int neighbor_col = (col + dc + 16) % 16;
          int neighbor_index = neighbor_row * 16 + neighbor_col;

          neighbors += q[neighbor_index];
        }
      }

      // Update the cell based on the number of neighbors
      if (neighbors >= 4) begin
        next_q[i] = 0;
      end else if (neighbors == 0) begin
        next_q[i] = 0;
      end else if (neighbors == 1) begin
        next_q[i] = 0;
      end else if (neighbors == 3) begin
        next_q[i] = 1;
      end else begin
        next_q[i] = q[i];
      end
    end
  end

endmodule
