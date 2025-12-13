
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
  // Define the states
  parameter OFF = 2'b00;
  parameter ON  = 2'b01;

  // Declare the state register
  reg current_state;
  reg out;

  // Assign the output based on the current state
  always @(current_state) begin
    case (current_state)
      OFF: out = 0;
      ON:  out = 1;
      default: out = 0; // Should never happen, but good practice
    endcase
  end

  // Synchronous reset and state transition logic
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      current_state <= OFF;
    end else begin
      case (current_state)
        OFF: begin
          if (j) begin
            current_state <= ON;
          end else begin
            current_state <= OFF;
          end
        end
        ON: begin
          if (k) begin
            current_state <= OFF;
          end else begin
            current_state <= ON;
          end
        end
        default: current_state <= OFF; // Should never happen, but good practice
      endcase
    end
  end

endmodule
