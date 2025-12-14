
module TopModule(
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state; // States A and B
reg [2:0] w_history; // 3 bit counter to keep track of consecutive ones
reg int_count; // counter for the number of consecutive ones

// Initialize states and counters
initial begin
    state = 2'b00;
    w_history = 3'b000;
    int_count = 0;
end

always @(posedge clk) begin
    if (reset) begin
        state = 2'b00;
        w_history = 3'b000;
        int_count = 0;
    end else if (~s && state == 2'b00) begin // When s is low and we are in state A, do nothing
        continue;
    end else if (s && state == 2'b00) begin // When s is high and we are in state A, move to state B
        state = 2'b01;
    end else if (state == 2'b01) begin
        w_history <= w; // Store the value of w
        int_count++; // Increment the counter

        if (int_count >= 3 && ~w[0] && ~w[1] && w[2]) begin // If we have three consecutive ones, set z to 1
            z = 1;
        end else if (int_count == 2) begin // If we only have two consecutive ones, don't set z yet
            int_count <= 0; // Reset the counter
        end

        if (~w[0] && ~w[1] && w[2]) begin // When we are done with three consecutive ones
            state = 2'b00;
            w_history = 3'b000;
            int_count = 0;
        end
    end
end

assign z = state; // Assign the current state to z

endmodule

// VERILOG-EVAL: errant inclusion of module definition
