
module TopModule (
    input clk,
    input reset,
    input [3:1] s, // sensors asserted
    output reg fr3,   // flow rate to valve 3
    output reg fr2,   // flow rate to valve 2
    output reg fr1,   // flow rate to valve 1
    output reg dfr     // supplemental flow valve control
);

// State machine variables
reg [7:0] prev_state; // previous state of the water level
reg [3:0] s_prev;     // sensors asserted in previous state

// Initialize previous state and sensors assertion for first state
reg initial_state = 1;
reg initial_s_prev = 2;

// State machine logic
always @(posedge clk) begin
    if (reset) begin
        prev_state <= $unsigned(initial_state);
        s_prev <= $unsigned(initial_s_prev);
        fr3 <= 0; // No flow when water level is above the highest sensor
        fr2 <= 0;
        fr1 <= 0;
        dfr <= 0;
    end else begin
        int state = $unsigned(prev_state);
        int s_curr = $unsigned(s);

        if (state == 8 && (~s[3] & ~s[2])) { // Water level above the highest sensor
            prev_state <= 1; // Transition to low water level state
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 0;
            dfr <= 0;

        } else if (state == 7 && (~s[2] & ~s[1])) { // Water level between the highest and middle sensors
            prev_state <= 6; // Transition to neutral state
            fr3 <= $unsigned({'0', '0', '0', '0'}); // Flow is nominal for both valves
            fr2 <= $unsigned({'0', '0', '0', '1'});
            fr1 <= $unsigned({'0', '0', '1', '1'});
            dfr <= 0;

        } else if (state == 6 && (~s[1] & ~s[0])) { // Water level between the middle and lowest sensors
            prev_state <= 5; // Transition to high water level state
            fr3 <= $unsigned({'0', '0', '0', '0'});
            fr2 <= $unsigned({'0', '0', '1', '1'});
            fr1 <= $unsigned({'0', '1', '1', '1'});
            dfr <= 0;

        } else if (state == 5 && (~s_prev[3] & ~s_prev[2])) { // Water level between the lowest and highest sensors, increasing flow
            prev_state <= 4; // Transition to high water level state
            fr3 <= $unsigned({'1', '0', '1', '1'});
            fr2 <= $unsigned({'1', '0', '1', '0'});
            fr1 <= $unsigned({'0', '1', '1', '0'});
            dfr <= 1; // Enable supplemental flow valve

        } else if (state == 4 && (~s_prev[2] & ~s_prev[1])) { // Water level between the highest and middle sensors, increasing flow
            prev_state <= 3; // Transition to low water level state
            fr3 <= $unsigned({'0', '0', '1', '1'});
            fr2 <= $unsigned({'0', '1', '1', '1'});
            fr1 <= $unsigned({'1', '0', '1', '1'});
            dfr <= 1; // Enable supplemental flow valve

        } else if (state == 3 && (~s_prev[1] & ~s_prev[0])) { // Water level between the middle and lowest sensors, increasing flow
            prev_state <= 2; // Transition to high water level state
            fr3 <= $unsigned({'0', '1', '1', '1'});
            fr2 <= $unsigned({'0', '0', '1', '0'});
            fr1 <= $unsigned({'0', '1', '1', '0'});
            dfr <= 1; // Enable supplemental flow valve

        } else if (state == 2 && (~s_prev[0])) { // Water level above the lowest sensor
            prev_state <= 1; // Transition to low water level state
            fr3 <= $unsigned({'0', '0', '0', '0'});
            fr2 <= $unsigned({'0', '0', '1', '0'});
            fr1 <= $unsigned({'0', '1', '1', '0'});
            dfr <= 1; // Enable supplemental

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
