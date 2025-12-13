
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else begin
    logic [255:0] new_q; // Temporary register to store the next state

    // Iterate through each cell in the grid and calculate its new state based on neighbors
    for (int i = 0; i < 256; i++) begin
      int count = 0;

      // Check all eight neighbor cells and increment the count if alive
      if (i == NEIGHBOR_INDEX(15, 1)) count += q[(i + 1) % 256];
      else if (i == NEIGHBOR_INDEX(15, 0)) count += q[(i - 17) % 256];
      else if (i == NEIGHBOR_INDEX(15, 15)) count += q[(i + 18) % 256];
      else if (i == NEIGHBOR_INDEX(0, 1)) count += q[(i - 1) % 256];
      else if (i == NEIGHBOR_INDEX(0, 15)) count += q[(i + 19) % 256];
      else if (i == NEIGHBOR_INDEX(1, 1)) count += q[(i - 18) % 256];
      else if (i == NEIGHBOR_INDEX(1, 0)) count += q[(i + 17) % 256];
      else if (i == NEIGHBOR_INDEX(1, 15)) count += q[(i - 19) % 256];

      // Apply the game of life rules to determine the new state of the cell
      if (count < 2 || count > 3)
        new_q[i] = 0;
      else if (count == 2 || count == 3)
        new_q[i] = q[i];

    end

    // Assign the new state to the q register
    q <= new_q;
  end
end

// Macro to calculate the index of a neighbor cell in the toroidal grid
#define NEIGHBOR_INDEX(row, col) \
    ((row + 1) % 16 * 16 + (col + 1) % 16)


// VERILOG-EVAL: endmodule not found
