
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
  reg [2:0] current_state, next_state;
  assign z = (current_state == 3'b101) || (current_state == 3'b110);

  always @(posedge clk or posedge reset) begin
      if (reset)
          current_state <= 3'b000; // Initial state A
      else
          current_state <= next_state;
  end

  always @(*) begin
      case (current_state)
          3'b000: // State A
              if (!w)
                  next_state = 3'b001; // Go to B
              else
                  next_state = 3'b000; // Stay in A

          3'b001: // State B
              if (!w)
                  next_state = 3'b010; // Go to C
              else
                  next_state = 3'b011; // Go to D

          3'b010: // State C
              if (!w)
                  next_state = 3'b100; // Go to E
              else
                  next_state = 3'b011; // Go to D

          3'b011: // State D
              if (!w)
                  next_state = 3'b101; // Go to F
              else
                  next_state = 3'b000; // Go to A

          3'b100: // State E
              if (w)
                  next_state = 3'b011; // Go to D
              else
                  next_state = 3'b100; // Stay in E

          3'b101: // State F
              if (w)
                  next_state = 3'b011; // Go to D
              else
                  next_state = 3'b010; // Go to C

          default:
              next_state = 3'b000;
      endcase
  end

endmodule
