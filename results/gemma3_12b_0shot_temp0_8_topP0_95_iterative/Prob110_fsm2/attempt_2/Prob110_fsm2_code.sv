
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
  // Define the states
  parameter OFF = 2'b00;
  parameter ON  = 2'b01;

  // Declare state register
  reg current_state;

  // Assign output based on current state (Moore machine)
  always @(current_state) begin
    case (current_state)
      OFF: out = 0;
      ON:  out = 1;
      default: out = 0; // Default to 0 for unknown states
    endcase
  end

  // Synchronous state transition logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
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
        default: current_state <= OFF; // Default to OFF for unknown states
      endcase
    end
  end

endmodule
