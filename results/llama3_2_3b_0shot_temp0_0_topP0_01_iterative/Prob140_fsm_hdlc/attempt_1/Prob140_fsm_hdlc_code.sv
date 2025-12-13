
module TopModule(
    input clk, // Positive clock signal
    input reset, // Active high synchronous reset signal
    input in, // Input bit stream
    output disc, // Discard signal
    output flag, // Flag signal for frame boundaries
    output err  // Error signal for 7 or more consecutive 1s
);

// Define the states of the FSM
typedef enum reg [2:0] {
    START,
    ONE,
    FIVE,
    FLAG,
    ERROR
} state_t;

// Initialize the state to START when reset is active high
state_t state = '0;

// Define the next state for each input bit
always @(posedge clk) begin
    if (reset) begin // Reset condition
        state <= START;
    else if (in == 1) begin // One consecutive 1
        if (state == START || state == ONE) begin // Transition from START or ONE to FIVE
            state <= FIVE;
        end else if (state == FLAG) begin // Transition from FLAG to ERROR
            state <= ERROR;
        end else if (state == ERROR) begin // Transition from ERROR back to START
            state <= START;
        end
    else if (in == 0) begin // Zero after five consecutive 1s
        if (state == FIVE) begin // Transition from FIVE to FLAG
            state <= FLAG;
        end else if (state == ONE || state == ERROR) begin // Reset the state
            state <= START;
        end
    end
end

// Define the output signals based on the current state
always @(*) begin
    case(state)
        START: disc = 0; flag = 0; err = 0;
        ONE: disc = 0; flag = 0; err = 0;
        FIVE: disc = 0; flag = 0; err = 0;
        FLAG: disc = 1; flag = 1; err = 0;
        ERROR: disc = 1; flag = 0; err = 1;
    endcase
end

// Output signals
assign disc = disc;
assign flag = flag;
assign err = err;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
