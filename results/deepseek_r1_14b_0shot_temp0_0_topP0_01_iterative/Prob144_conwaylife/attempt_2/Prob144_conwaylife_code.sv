
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

reg [255:0] next_q;

always @posedge clk begin
    if (load) begin
        q <= data;
    end else begin
        // Calculate next state for each cell in the grid
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                // Current cell index
                int idx = i * 16 + j;
                
                // Count live neighbors
                int count = 0;
                // Check all 8 neighbors
                for (int di = -1; di <= 1; di++) begin
                    for (int dj = -1; dj <= 1; dj++) begin
                        if (di == 0 && dj == 0) continue; // Skip current cell
                        int ni = i + di;
                        int nj = j + dj;
                        // Wrap around toroidally
                        ni = (ni < 0) ? 15 : (ni >= 16 ? 0 : ni);
                        nj = (nj < 0) ? 15 : (nj >= 16 ? 0 : nj);
                        int neighbor_idx = ni * 16 + nj;
                        if (q[neighbor_idx]) count++;
                    end
                end
                
                // Determine next state based on rules
                if (count == 2 || count == 3) begin
                    next_q[idx] <= q[idx]; // Stay same if count is 2 or 3
                end else begin
                    next_q[idx] <= (count == 3); // Become 1 only if exactly 3 neighbors
                end
            end
        end
        
        // Assign new state to output after all cells are processed
        q <= next_q;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
