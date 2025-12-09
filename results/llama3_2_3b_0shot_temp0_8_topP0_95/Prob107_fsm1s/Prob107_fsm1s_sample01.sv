
module TopModule (
  input clk, // Positive edge-triggered clock signal
  input in,   // Input signal
  input reset,// Active-high synchronous reset signal
  output out  // Output signal
);

reg [1:0] state; // State variable (2-bit)

// Reset state is B
always @(posedge clk) begin
    if (reset)
        state <= 2'b01;
    else
        state <= state;
end

// Moore machine behavior
always @(*)
begin
    case(state)
        2'b00: // State A
            if (!in)
                state <= 2'b01; // B
            else
                state <= 2'b10; // B
        2'b01: // State B
            if (in)
                state <= 2'b01; // B
            else
                state <= 2'b10; // A
        2'b11: // State A
            if (!in)
                state <= 2'b00; // A
            else
                state <= 2'b11; // A
    endcase

    out = {state[1], ~state[0]}; // Output signal
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
