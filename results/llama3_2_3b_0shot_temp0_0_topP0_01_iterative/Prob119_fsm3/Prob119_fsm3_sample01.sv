
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
reg [1:0] state;
reg [1:0] next_state;

// Asynchronous reset
always @(posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end else begin
        state <= next_state;
    end
end

// State transition table
always @(*) begin
    case(state)
        2'b00: // State A
            next_state = 2'b01;

        2'b01: // State B
            next_state = 2'b11;

        2'b10: // State C
            next_state = 2'b01;

        2'b11: // State D
            next_state = 2'b10;
    endcase
end

// Output logic (Moore machine)
assign out = state[1];

endmodule

// VERILOG-EVAL: abnormal backticks count
