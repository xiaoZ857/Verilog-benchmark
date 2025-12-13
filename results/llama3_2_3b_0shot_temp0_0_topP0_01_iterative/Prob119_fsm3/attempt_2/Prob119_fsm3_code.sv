
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
            if(in == 0) next_state = 2'b01;
            else if(in == 1) next_state = 2'b10;
            else next_state = state; // No change

        2'b01: // State B
            if(in == 0) next_state = 2'b11;
            else if(in == 1) next_state = 2'b00;
            else next_state = state; // No change

        2'b10: // State C
            if(in == 0) next_state = 2'b01;
            else if(in == 1) next_state = 2'b11;
            else next_state = state; // No change

        2'b11: // State D
            if(in == 0) next_state = 2'b10;
            else if(in == 1) next_state = 2'b00;
            else next_state = state; // No change
    endcase
end

// Output logic (Moore machine)
assign out = state[1];

endmodule
