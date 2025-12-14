
module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg current_state = 0; // 0 for State A, 1 for State B
reg count_w = 0; // Counter for the number of times w is equal to 1 within a sequence of three clocks in State B

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= 0; // Reset to State A
    end else if (current_state == 0 && s == 1) begin
        // Transition from State A to State B when s = 1
        current_state <= 1;
        count_w <= 0; // Reset counter when entering State B
    end else if (current_state == 1) begin
        // In State B, check w for the next three clock cycles
        if (count_w < 2 && w == 1) begin
            count_w += 1;
        end else if (count_w >= 3) begin
            // If w was equal to 1 in all three clock cycles, reset counter
            count_w <= 0;
        end
        if (count_w == 2 && (posedge clk)) begin
            // Set z to 1 when the condition is satisfied
            z <= 1;
        end
    end
end

always @(negedge clk) begin
    // Reset output z after one clock cycle when transitioning from State B back to State A
    if (current_state == 0 && w != 1) begin
        z <= 0;
    end
end

// The FSM has two registers, current_state and count_w, which are active-low
always @(posedge clk negedge reset) begin
    if (reset) begin
        q[0] <= 0; // Reset register q[0] to 0
        q[1] <= 0; // Reset register q[1] to 0
    end else if (current_state == 1) begin
        // When in State B, store the current value of w into register q[0]
        q[0] <= w;
    end else if ((posedge clk) && (current_state == 0)) begin
        // When transitioning from State B back to State A, store the value of register q[1] into z
        z <= q[1];
        // Reset register q[1] to 0 and move its value to register q[0] for the next cycle
        q[1] <= q[0];
        q[0] <= 0;
    end
end

// This part of the code is to store the current value of w in a register during State B, which is not explicitly mentioned in the description.
always @(posedge clk) begin
    if (current_state == 1) begin
        q[1] <= w; // Store the current value of w into register q[1] when in State B
    end
end

// Assigning active-high registers to Verilog's active-low registers
reg current_state_active_high = ~current_state;
reg count_w_active_high = ~count_w;
reg q[2] = {q[1], q[0]}; // Combining registers q[0] and q[1]

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
