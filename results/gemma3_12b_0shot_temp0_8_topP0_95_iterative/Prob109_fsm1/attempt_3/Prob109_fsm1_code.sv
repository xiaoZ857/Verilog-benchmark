
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
  // Define states
  parameter A = 2'b00
  parameter B = 2'b01

  // State register
  reg current_state;

  // Output register
  reg out;

  // Synchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= B;
    end else begin
      case (current_state)
        A: begin
          if (in == 0) begin
            current_state <= B;
          end else begin
            current_state <= A;
          end
          out <= 0;
        end
        B: begin
          if (in == 0) begin
            current_state <= B;
          end else begin
            current_state <= A;
          end
          out <= 1;
        end
        default: begin
          current_state <= B; // Default to a known state
          out <= 1;
        end
      endcase
    end
  end

endmodule
