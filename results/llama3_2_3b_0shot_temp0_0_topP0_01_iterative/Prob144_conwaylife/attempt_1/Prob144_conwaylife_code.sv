
// Define the number of rows and columns in the grid
#define NUM_ROWS 16
#define NUM_COLS 16

// Define the size of the vector representing the grid
#define GRID_SIZE (NUM_ROWS * NUM_COLS)

module TopModule (
  input clk,
  input load,
  input [GRID_SIZE-1:0] data,
  output reg [GRID_SIZE-1:0] q
);

// Initialize the grid with all cells set to 0
reg [GRID_SIZE-1:0] q_init = {GRID_SIZE-1: 0};

// Calculate the number of neighbors for each cell
function signed [3:0] count_neighbors(signed [2:0] row, signed [2:0] col);
    // Define the indices of the neighboring cells
    signed [2:0] i_row = {row[1], row[0], 0};
    signed [2:0] i_col = {col[1], col[0], 0};

    // Calculate the indices of the neighboring cells in the toroid grid
    signed [GRID_SIZE-1:0] n_i_row = (i_row + 8) % GRID_SIZE;
    signed [GRID_SIZE-1:0] n_i_col = (i_col + 8) % GRID_SIZE;

    // Count the number of neighbors
    signed [3:0] count = {n_i_row[15], n_i_row[14], n_i_row[13], n_i_row[12]};
    return count;
endfunction

// Calculate the state of each cell based on its neighbors
function signed [2:0] get_state(signed [3:0] count);
    // Define the states for different counts of neighbors
    case(count)
        0: return {0, 0, 0};
        1: return {0, 0, 0};
        2: return {0, 0, 0};
        3: return {1, 1, 1};
        default: return {0, 0, 0};
    endcase
endfunction

// Main module logic
always @(posedge clk) begin
    // If the load signal is active high, update the grid state
    if (load) begin
        q_init = data;
    end else begin
        // Update the grid state based on the current state and neighbors
        signed [GRID_SIZE-1:0] new_q = {GRID_SIZE-1: 0};
        for (signed [2:0] row = 0; row < NUM_ROWS; row++) begin
            for (signed [2:0] col = 0; col < NUM_COLS; col++) begin
                signed [3:0] count = count_neighbors(row, col);
                signed [2:0] state = get_state(count);
                new_q[(row * NUM_COLS) + col] = state;
            end
        end

        // Assign the updated grid state to q
        q = new_q;
    end
end

// Initialize the module with the initial grid state
initial begin
    q = q_init;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
