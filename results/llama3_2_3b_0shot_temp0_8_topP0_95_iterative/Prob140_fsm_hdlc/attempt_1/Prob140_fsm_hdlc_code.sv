
module TopModule(
    input clk,     // Positive clock/clk triggered signal
    input reset,    // Active high synchronous reset signal
    input in,       // Input bit from the data stream
    output disc,   // Signal to discard a bit when 0111110 is detected
    output flag,   // Flag for the beginning/end of a frame (packets)
    output err      // Error signal for detecting more than 7 consecutive 1s
);

reg [2:0] state;  // State variable
reg [3:2] prev_state;  // Previous state to track transitions

// States and their corresponding next states
wire [2:0] state_next;
assign state_next = {
    {3, 0, 0},     // Initial state (reset), disc is asserted after 5 consecutive 1s
    {2, 0, 0},
    {1, 1, 0},
    {0, 0, 0}
};

// States and their corresponding next prev_state values
reg [3:2] prev_state_next;
assign prev_state_next = {
    {3, 3},     // Reset to state 3 from any previous state (disc is asserted after 5 consecutive 1s)
    {2, 2},
    {1, 1},
    {0, 0}
};

// Assign initial states
initial begin
    state     = 3;   // State 3 for the first cycle
    prev_state = 3;   // Previous state to track transitions from reset
end

always @(posedge clk) begin
    if (reset) begin
        state = 3;
        prev_state = 3;
    end else if (in == '1' && prev_state_next == {2, 0}) begin
        state = {2, 0};
        prev_state = {3, 3};
    end else if ((prev_state == {1, 0} || prev_state == {0, 0})) begin
        state = {1, 1};
        prev_state = {1, 0};
    end else if (in == '1' && prev_state_next[2:1] == {2}) begin
        state = {3, 2}; // Error detected with more than 7 consecutive 1s
        err   <= 1;
        disc   <= 1;
    end else if (in == '0') begin
        state = {0, 0};
        prev_state = {1, 1};
    end else begin
        state = {2, 0}; // Reset to initial state when disc is asserted after 5 consecutive 1s
        prev_state = {3, 3};
    end
    
end

// Generate disc signal for every fifth bit
assign disc = (state == {2, 0}) ? in : '0';

// Flag the beginning/end of a frame (packets)
assign flag = state == {3, 0};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
