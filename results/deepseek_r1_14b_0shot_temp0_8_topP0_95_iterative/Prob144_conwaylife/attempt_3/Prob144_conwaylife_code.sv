
`timescale 1ns / 1ps

module TopModule (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @ (posedge clk) begin
    if (load == 1) begin
        q <= data;
    end else begin
        // Conway's Game of Life rules
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                // Calculate current cell index
                integer idx = i * 16 + j;
                
                // Count live neighbors
                integer count = 0;
                // Check all 8 neighbors, wrapping around edges
                for (int di = -1; di <= 1; di++) begin
                    for (int dj = -1; dj <= 1; dj++) begin
                        if (! (di == 0 && dj == 0)) begin // Skip current cell
                            integer ni = (i + di) % 16;
                            integer nj = (j + dj) % 16;
                            integer nidx = ni * 16 + nj;
                            if (q[nidx] == 1) count++;
                        end
                    end
                end
                
                // Apply rules to determine next state
                if (q[idx] == 0) begin
                    // Dead cell: becomes alive only if exactly 3 neighbors
                    next_q[idx] <= (count == 3);
                end else begin
                    // Live cell: dies unless 2 or 3 neighbors
                    next_q[idx] <= (count == 2 || count == 3);
                end
            end
        end
        
        q <= next_q;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
