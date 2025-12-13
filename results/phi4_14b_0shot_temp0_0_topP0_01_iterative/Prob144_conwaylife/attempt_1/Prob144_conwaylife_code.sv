
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  // Temporary register to hold the next state
  reg [255:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      // Load new initial state into q
      q <= data;
    end else begin
      // Update the game state
      q <= next_q;
    end
  end

  integer x, y, nx, ny;
  reg [3:0] live_neighbors;

  always @(*) begin
    // Initialize next_q to zero
    next_q = 256'b0;

    for (x = 0; x < 16; x = x + 1) begin
      for (y = 0; y < 16; y = y + 1) begin
        live_neighbors = 0;

        // Calculate the number of live neighbors with toroidal wrapping
        for (nx = -1; nx <= 1; nx = nx + 1) begin
          for (ny = -1; ny <= 1; ny = ny + 1) begin
            if (!(nx == 0 && ny == 0)) begin
              // Calculate wrapped coordinates
              integer neighbor_x = (x + nx + 16) % 16;
              integer neighbor_y = (y + ny + 16) % 16;

              // Check if the neighbor is alive
              if (q[neighbor_x * 16 + neighbor_y]) begin
                live_neighbors = live_neighbors + 1;
              end
            end
          end
        end

        // Determine next state of the cell based on Game of Life rules
        case (live_neighbors)
          0, 1: next_q[x*16 + y] = 0; // Rule 1 and 4
          2: next_q[x*16 + y] = q[x*16 + y]; // Rule 2
          3: next_q[x*16 + y] = 1; // Rule 3
          default: next_q[x*16 + y] = 0; // Rule 4 (4+ neighbors)
        endcase
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
