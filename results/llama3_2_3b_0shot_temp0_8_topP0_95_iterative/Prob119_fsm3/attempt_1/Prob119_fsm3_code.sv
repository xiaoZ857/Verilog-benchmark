
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
module StateMachine(
    input clk,
    input in,
    input areset,
    output reg [1:0] out,
    input [1:0] state
);

reg [1:0] current_state;
assign out = current_state;

// Initialize state to A on reset
initial begin
    if (areset) {
        current_state <= 2'b00; // State A
    }
end

always @(posedge clk or areset) begin
    // Asynchronous reset
    if (areset || current_state == 2'b00) { // A
        current_state <= 2'b00; // Reset to state A
    } else begin
        // Transition table
        case(current_state)
            2'b00: // State A
                when(in == 0) out = 2'b00;
                when(in == 1) out = 2'b01;
            
            2'b01: // State B
                when(in == 0) out = 2'b01;
                when(in == 1) out = 2'b10;
            
            2'b10: // State C
                when(in == 0) out = 2'b10;
                when(in == 1) out = 2'b11;
            
            default: // State D
                when(in == 0) out = 2'b00;
                when(in == 1) out = 2'b01;
        endcase
    end
end

endmodule
