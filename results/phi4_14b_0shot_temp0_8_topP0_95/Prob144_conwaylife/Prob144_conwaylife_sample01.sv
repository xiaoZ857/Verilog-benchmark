
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  integer i;
  
  always @(posedge clk) begin
    if (load) begin
      // Load initial state into q on load signal
      q <= data;
    end else begin
      // Temporary register to hold the new state
      reg [255:0] next_q;

      for (i = 0; i < 256; i = i + 1) begin
        integer row, col;
        
        // Calculate current row and column from index
        row = i / 16;
        col = i % 16;

        // Count live neighbors using toroidal wrapping
        integer live_neighbors = 0;
        for (integer dr = -1; dr <= 1; dr++) begin
          for (integer dc = -1; dc <= 1; dc++) begin
            if (!(dr == 0 && dc == 0)) begin // Skip the cell itself
              integer neighbor_row, neighbor_col;

              // Calculate toroidal wrapping indices
              neighbor_row = (row + dr + 16) % 16;
              neighbor_col = (col + dc + 16) % 16;

              // Convert to 1D index and check if the neighbor is alive
              live_neighbors += q[neighbor_row * 16 + neighbor_col];
            end
          end
        end

        // Apply Game of Life rules
        case (q[i])
          0: next_q[i] = (live_neighbors == 3) ? 1 : 0;
          1: next_q[i] = ((live_neighbors == 2) || (live_neighbors == 3)) ? 1 : 0;
        endcase
      end

      // Update the state of q with the calculated new state
      q <= next_q;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
