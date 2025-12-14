
module TopModule (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Temporary register to hold the next state of the grid
    reg [255:0] next_q;

    always_ff @(posedge clk) begin
        if (load) begin
            // Load the initial state into q if load is high
            q <= data;
        end else begin
            // Update the game state
            q <= next_q;
        end
    end

    always_comb begin
        static integer i, j, ni, nj, live_neighbors;

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
                case ({4'b0000, live_neighbors, q[i*16+j]})
                    {4'b0001, 3'b001, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (1)
                    {4'b0010, 3'b010, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (1)
                    {4'b0100, 3'b100, 1'b0}: ;                      // Rule (2), no change
                    {4'b0100, 3'b100, 1'b1}: next_q[i*16+j] = q[i*16+j]; // Rule (2), no change
                    {4'b0110, 3'b110, 1'b0}: next_q[i*16+j] = 1'b1; // Rule (3)
                    {4'b0110, 3'b110, 1'b1}: next_q[i*16+j] = 1'b1; // Rule (3)
                    {4'b1001, 3'b001, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {4'b1001, 3'b001, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {4'b1011, 3'b011, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {4'b1011, 3'b011, 1'b1}: next_q[i*16+b] = 1'b0; // Rule (4)
                    {4'b1101, 3'b101, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {4'b1101, 3'b101, 1'b1}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {4'b1110, 3'b110, 1'b0}: next_q[i*16+j] = 1'b0; // Rule (4)
                    {4'b1110, 3'b110, 1'b1}: next_q[i*16+j] = 1'b0;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
