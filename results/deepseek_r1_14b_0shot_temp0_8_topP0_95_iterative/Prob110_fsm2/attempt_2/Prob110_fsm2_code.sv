
// Set the simulation time scale
`timescale 1ns / 1ps

module TopModule (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define state variables
    reg state;
    wire next_state;

    // State transitions and next state calculation
    always @* begin
        case (state)
            0: 
                if (j == 1) begin
                    next_state = 1;
                end else begin
                    next_state = 0;
                end
            1: 
                if (k == 1) begin
                    next_state = 0;
                end else begin
                    next_state = 1;
                end
        endcase
    end

    // Clocked D flip-flop for state storage
    always @(posedge clk or areset) begin
        if (areset) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic based on current state
    assign out = (state == 1) ? 1 : 0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
