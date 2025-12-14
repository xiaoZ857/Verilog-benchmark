
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  // Internal register to hold next state
  reg [255:0] next_q;
  
  integer i, j;
  reg [3:0] neighbor_count;
  reg current_cell;
  reg [4:0] row_above, row_below, col_left, col_right;
  reg [7:0] neighbor_idx;
  
  always @(*) begin
    // Calculate next state for each cell
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        // Calculate wrap-around indices
        row_above = (i == 0) ? 15 : i - 1;
        row_below = (i == 15) ? 0 : i + 1;
        col_left = (j == 0) ? 15 : j - 1;
        col_right = (j == 15) ? 0 : j + 1;
        
        // Count neighbours
        neighbor_count = 0;
        
        // Top row neighbours
        neighbor_idx = row_above * 16 + col_left;
        neighbor_count = neighbor_count + q[neighbor_idx];
        neighbor_idx = row_above * 16 + j;
        neighbor_count = neighbor_count + q[neighbor_idx];
        neighbor_idx = row_above * 16 + col_right;
        neighbor_count = neighbor_count + q[neighbor_idx];
        
        // Same row neighbours (left and right)
        neighbor_idx = i * 16 + col_left;
        neighbor_count = neighbor_count + q[neighbor_idx];
        neighbor_idx = i * 16 + col_right;
        neighbor_count = neighbor_count + q[neighbor_idx];
        
        // Bottom row neighbours
        neighbor_idx = row_below * 16 + col_left;
        neighbor_count = neighbor_count + q[neighbor_idx];
        neighbor_idx = row_below * 16 + j;
        neighbor_count = neighbor_count + q[neighbor_idx];
        neighbor_idx = row_below * 16 + col_right;
        neighbor_count = neighbor_count + q[neighbor_idx];
        
        // Get current cell state
        current_cell = q[i * 16 + j];
        
        // Apply Game of Life rules
        if (neighbor_count <= 1) begin
          next_q[i * 16 + j] = 1'b0;
        end else if (neighbor_count == 2) begin
          next_q[i * 16 + j] = current_cell;
        end else if (neighbor_count == 3) begin
          next_q[i * 16 + j] = 1'b1;
        end else begin
          next_q[i * 16 + j] = 1'b0;
        end
      end
    end
  end
  
  // Update state on clock edge
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end
endmodule
