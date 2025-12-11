
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
reg [2:0] current_state, next_state;
wire [2:0] encoded_states;

assign encoded_states = {current_state[2], current_state[1], current_state[0]};
assign z = (encoded_states == 3'b101) | (encoded_states == 3'b110);

always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= 3'b000;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        3'b000: // State A
            if (!w)
                next_state = 3'b001; // B
            else
                next_state = 3'b000; // A
        
        3'b001: // State B
            if (!w)
                next_state = 3'b010; // C
            else
                next_state = 3'b011; // D
        
        3'b010: // State C
            if (!w)
                next_state = 3'b100; // E
            else
                next_state = 3'b011; // D
        
        3'b011: // State D
            if (!w)
                next_state = 3'b101; // F
            else
                next_state = 3'b000; // A
        
        3'b100: // State E
            if (w)
                next_state = 3'b011; // D
            else
                next_state = 3'b100; // E
        
        3'b101: // State F
            if (w)
                next_state = 3'b011; // D
            else
                next_state = 3'b010; // C

        default:
            next_state = 3'b000;
    endcase
end

endmodule
