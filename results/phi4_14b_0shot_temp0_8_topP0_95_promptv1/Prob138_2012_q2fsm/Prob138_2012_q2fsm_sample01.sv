
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
reg [2:0] state, next_state;
wire [2:0] current_state;

assign current_state = state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // State A
    else
        state <= next_state;
end

always @(*) begin
    case (current_state)
        3'b000: begin // State A
            if (w)
                next_state = 3'b001; // B
            else
                next_state = 3'b000; // A
        end
        3'b001: begin // State B
            if (w)
                next_state = 3'b010; // C
            else
                next_state = 3'b011; // D
        end
        3'b010: begin // State C
            if (w)
                next_state = 3'b100; // E
            else
                next_state = 3'b011; // D
        end
        3'b011: begin // State D
            if (w)
                next_state = 3'b101; // F
            else
                next_state = 3'b000; // A
        end
        3'b100: begin // State E
            if (w)
                next_state = 3'b100; // E
            else
                next_state = 3'b011; // D
        end
        3'b101: begin // State F
            if (w)
                next_state = 3'b010; // C
            else
                next_state = 3'b011; // D
        end
        default:
            next_state = 3'b000; // Default to A
    endcase
end

assign z = (current_state == 3'b100); // Output z is high in state E

endmodule
