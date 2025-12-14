
module TopModule (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Temporary register to hold the next state of the grid
    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            // Load the initial state into q if load is high
            q <= data;
        end else begin
            // Update the game state
            q <= next_q;
        end
    end

    always @(*) begin
        integer i, j, ni, nj, live_neighbors;

        // Initialize the next state to be the same as current state
        next_q = q;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                live_neighbors = 0;
                
                // Check all 8 neighbors, considering toroidal wrapping
                for (ni = -1; ni <= 1; ni = ni + 1) begin
                    for (nj = -1; nj <= 1; nj = nj + 1) begin
                        if (!(ni == 0 && nj == 0)) begin
                            // Calculate wrapped indices
                            integer neighbor_i = (i + ni + 16) % 16;
                            integer neighbor_j = (j + nj + 16) % 16;

                            // Check the state of the neighbor cell
                            if (q[neighbor_i * 16 + neighbor_j]) begin
                                live_neighbors = live_neighbors + 1;
                            end
                        end
                    end
                end

                // Determine the next state based on current state and neighbors
                case ({live_neighbors, q[i*16+j]})
                    {0, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (1)
                    {1, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (1)
                    {2, 1'b0}: ;                      // Rule (2), no change
                    {2, 1'b1}: next_q[i*16+j] = 1'b1; // Rule (2), no change
                    {3, 1'b0}: next_q[i*16+j] = 1'b1; // Rule (3)
                    {3, 1'b1}: next_q[i*16+j] = 1'b1; // Rule (3)
                    {4'b1010, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {4'b1010, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {5'b10110, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {5'b10110, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {6'b101110, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {6'b101110, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {7'b1011110, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {7'b1011110, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {8'b10111110, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {8'b10111110, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (4)
                endcase
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
