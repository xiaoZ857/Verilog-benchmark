

module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in) ? 2'b01 : 2'b00; // Next state in=1 is B, else A
        end
        2'b01: begin // State B
            next_state = (in) ? 2'b01 : 2'b10; // Next state in=1 is B, else C
        end
        2'b10: begin // State C
            next_state = (in) ? 2'b11 : 2'b00; // Next state in=1 is D, else A
        end
        2'b11: begin // State D
            next_state = (in) ? 2'b11 : 2'b10; // Next state in=1 is B, else C
        end
    endcase
end

assign out = (state == 2'b11 && !in) ? 1'b1 : 1'b0;

endmodule
