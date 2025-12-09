
module TopModule(
    input clk,
    input reset,
    input in,
    output disc,      // signal for discarding bits
    output flag,       // frame boundary
    output err         // error if 7 or more consecutive 1s
);

// States of the finite state machine
localparam [2:0] initial_state = 3'b000;
localparam [2:0] disc_state = 3'b010;
localparam [2:0] flag_state = 3'b100;

// Current state of the finite state machine
reg [2:0] current_state = initial_state;

// Outputs for each state
wire [1:0] next_state_disc, next_state_flag;
wire [1:0] next_state_err;

// Outputs for error detection
assign err = (current_state == 3'b111);

// Outputs for frame boundary detection
assign flag = ((current_state == flag_state) && (in == 1));

// Output for discarding bits
assign disc = (next_state_disc != current_state);

// Define state transitions
always @(posedge clk or posedge reset) begin
    if(reset)
        current_state <= initial_state;
    else
        case(current_state)
            initial_state: next_state_disc <= 0;
            disc_state:      next_state_disc <= 1;
            flag_state:      next_state_flag <= 0;
            err_state:       next_state_err <= 0;
            // Discarding bits
            3'b000: if(in == 1) current_state <= disc_state; else current_state <= initial_state;
            3'b010: if(in == 1) current_state <= flag_state; else current_state <= disc_state;
            3'b100: if(in == 0) current_state <= flag_state; else current_state <= err_state;
            // Error detection
            3'b111: if(in == 0) current_state <= initial_state; else current_state <= err_state;
        endcase
    end

    // Update outputs for the next state
    assign disc = (next_state_disc != current_state);
    assign flag = ((current_state == flag_state) && (in == 1));
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
