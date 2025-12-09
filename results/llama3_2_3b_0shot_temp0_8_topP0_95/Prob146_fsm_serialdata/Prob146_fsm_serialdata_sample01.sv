
module TopModule (
    input clk, // Positive clock signal
    input in,   // Serial data input
    input reset, // Active-high synchronous reset
    output [7:0] out_byte,  // Output data byte
    output done        // Done signal for correct reception
);

// Finite state machine states
typedef enum reg [1:0] {
    IDLE,
    START_BIT,
    WAIT_DATA,
    STOP_BIT,
    VERIFIED
} fsm_state;

reg [1:0] state;  // Current state of the finite state machine

// Next state function
function fsm_state next_state(fsm_state current_state, input bit in)
begin
    case (current_state)
        IDLE:
            if (in == 1'b0) return START_BIT;
            else return IDLE;
        START_BIT:
            if (in == 1'b1) return WAIT_DATA;
            else return START_BIT;
        WAIT_DATA:
            if (in == 1'b1) return STOP_BIT;
            else return WAIT_DATA;
        STOP_BIT:
            if (in == 1'b0) return VERIFIED;
            else return IDLE; // Stop bit not received
        VERIFIED:
            return VERIFIED;
    endcase
endfunction

// State machine logic
always @(posedge clk orposedge in)
begin
    if (reset) state <= IDLE;
    else
    begin
        state <= next_state(state, in);
        case (state)
            START_BIT: out_byte[0] <= 1'b0; break;
            WAIT_DATA: out_byte[7:0] <= {in, in, in, in, in, in, in, in}; break;
            STOP_BIT: if (~in) state <= IDLE; else
                            begin
                                done <= 1'b1;
                                out_byte[7:0] <= '{1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
                                state <= VERIFIED;
                            end; break;
            IDLE: break;
        endcase
    end
end

// Output signals
assign out_byte[7:0] = done ? {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0} : out_byte[7:0];

endmodule // TopModule

// VERILOG-EVAL: errant inclusion of module definition
