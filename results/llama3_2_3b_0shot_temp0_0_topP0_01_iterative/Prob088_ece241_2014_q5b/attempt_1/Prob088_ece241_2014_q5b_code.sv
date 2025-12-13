
module TopModule(
    input clk, // Positive clock/clk triggered
    input areset, // Asynchronous active-high reset
    input x, // Input signal
    output reg [1:0] z // Output signal in one-hot encoding
);

reg [1:0] state; // State variable

// Initial state is A (z=0)
initial begin
    state = 2'b00;
end

always @(posedge clk) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end else begin
        case(state)
            2'b00: // State A
                if (!x) begin
                    state <= 2'b01; // Transition to B
                end
            2'b01: // State B
                if (x) begin
                    state <= 2'b10; // Transition to B
                end else begin
                    state <= 2'b00; // Stay in state B
                end
            2'b10: // State B
                if (!x) begin
                    state <= 2'b01; // Stay in state B
                end
        endcase
    end
end

assign z = {state[1], state[0]}; // Output signal in one-hot encoding

endmodule

// VERILOG-EVAL: errant inclusion of module definition
