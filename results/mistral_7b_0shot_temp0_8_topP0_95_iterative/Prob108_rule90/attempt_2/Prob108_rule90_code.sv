
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
reg [511:0] next_state;

always @(posedge clk) begin
    if (load)
        next_state <= data; // Load new state
    else
        begin
            for (int i = 0; i < 512; i++)
                next_state[(i+1)%512] = q[i] ^ q[(i+2)%512]; // Apply Rule 90 with correct indexing
        end
    assign q = next_state; // Assign new state to q
end

initial begin
    initial_state: for (int i = 0; i < 512; i++)
        next_state[i] <= 0; // Initialize all cells to off
end

// Initialization of the first state
always @(posedge clk) if (load && posedge $time > 0)
    initial_state; // Set the state after the first clock tick

// Boundary conditions
assign q[512] = 0; // Note: We already initialize q[-1] and q[512] to zero in the initialization block

endmodule
