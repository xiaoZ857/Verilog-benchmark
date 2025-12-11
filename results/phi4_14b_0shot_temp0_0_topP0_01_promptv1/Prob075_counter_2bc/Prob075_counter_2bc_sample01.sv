
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);
logic [1:0] next_state;

always @(posedge areset or posedge clk) begin
    if (areset)
        state <= 2'b01;
    else
        state <= next_state;
end

always @(*) begin
    case ({state, train_valid, train_taken})
        5'b00000: next_state = state; // No change when not training
        5'b01010: next_state = (state == 2'b11) ? state : state + 1; // Increment up to max 3
        5'b01001: next_state = (state == 2'b00) ? state : state - 1; // Decrement down to min 0
        default: next_state = state;
    endcase
end

endmodule
