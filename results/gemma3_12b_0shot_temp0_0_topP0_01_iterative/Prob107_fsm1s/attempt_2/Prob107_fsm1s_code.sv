
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
  // Define the states
  parameter B_STATE = 2'b00;
  parameter A_STATE = 2'b01;

  // Declare the state register
  reg current_state;

  // Define the next-state logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= B_STATE;
    end else begin
      case (current_state)
        B_STATE: begin
          if (in == 0) begin
            current_state <= A_STATE;
          end else begin
            current_state <= B_STATE;
          end
        end
        A_STATE: begin
          if (in == 0) begin
            current_state <= B_STATE;
          end else begin
            current_state <= A_STATE;
          end
        end
        default: begin
          current_state <= B_STATE; // Default to B_STATE in case of unexpected state
        end
      endcase
    end
  end

  // Define the output logic
  always @(current_state) begin
    case (current_state)
      B_STATE: out = 1;
      A_STATE: out = 0;
      default: out = 1; // Default to 1 in case of unexpected state
    endcase
  end

endmodule
