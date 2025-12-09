
module TopModule(
    input clk, // Positive edge trigger clock
    input in,   // Asynchronous input
    input areset,  // Asynchronous reset
    output out    // Output signal
);

    reg [1:0] state; // Current state of the machine (A or B)
    reg [1:0] nextState; // Next state of the machine

    // Initialize states
    initial begin
        state = 2'b01; // Start in state B
    end

    // Asynchronous reset logic
    always_ff @(posedge areset) begin
        if (areset) begin // If reset is high, set to state B
            state <= 2'b10;
        end else begin // Otherwise, keep the current state
            state <= nextState;
        end
    end

    // Moore machine logic
    always_ff @(posedge clk or negedge in) begin
        case (state)
            2'b01: // State B
                if (!in) begin // If input is low, move to A
                    nextState = 2'b00;
                end else if (in) begin // If input is high, stay in B
                    nextState = 2'b10;
                end
                break;

            2'b00: // State A
                if (!in) begin // If input is low, move to B
                    nextState = 2'b11;
                end else if (in) begin // If input is high, stay in A
                    nextState = 2'b00;
                end
                break;

            default:
                nextState = state; // Ignore unknown states
        endcase

        out <= $signed(nextState); // Output the next state
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
