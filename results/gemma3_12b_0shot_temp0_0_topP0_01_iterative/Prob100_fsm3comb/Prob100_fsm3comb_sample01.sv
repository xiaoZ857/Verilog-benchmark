
module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);
  always @(in, state) begin
    case (state)
      2'b00: begin // State A
        if (in == 0) begin
          next_state = 2'b00;
        end else begin
          next_state = 2'b01;
        end
      end
      2'b01: begin // State B
        if (in == 0) begin
          next_state = 2'b10;
        end else begin
          next_state = 2'b01;
        end
      end
      2'b10: begin // State C
        if (in == 0) begin
          next_state = 2'b00;
        end else begin
          next_state = 2'b11;
        end
      end
      2'b11: begin // State D
        if (in == 0) begin
          next_state = 2'b10;
        end else begin
          next_state = 2'b01;
        end
      end
      default: begin
        next_state = 2'b00; // Default to state A in case of an invalid state
      end
    endcase

    case (state)
      2'b00: out = 0;
      2'b01: out = 0;
      2'b10: out = 0;
      2'b11: out = 1;
      default: out = 0; // Default output in case of an invalid state
    endcase
  end

endmodule
