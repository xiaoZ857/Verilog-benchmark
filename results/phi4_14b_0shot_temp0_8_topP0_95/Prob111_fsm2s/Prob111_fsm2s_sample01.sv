
module TopModule (
  input wire clk,
  input wire j,
  input wire k,
  input wire reset,
  output reg out
);

  // State encoding
  parameter OFF = 1'b0;
  parameter ON  = 1'b1;

  // Internal state register
  reg current_state, next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Synchronous reset to OFF state
      current_state <= OFF;
    end else begin
      // Update state on clock edge
      current_state <= next_state;
    end
  end

  // Next state logic
  always @(*) begin
    case (current_state)
      OFF: begin
        if (j) begin
          next_state = ON;   // Transition to ON if j is high
        end else begin
          next_state = OFF;  // Remain in OFF if j is low
        end
      end

      ON: begin
        if (k) begin
          next_state = OFF;  // Transition to OFF if k is high
        end else begin
          next_state = ON;   // Remain in ON if k is low
        end
      end
      
      default:
        next_state = OFF;    // Default case for safety
    endcase
  end

  // Output logic (Moore)
  always @(*) begin
    case (current_state)
      OFF: out = 1'b0;
      ON:  out = 1'b1;
      default: out = 1'b0; // Default case for safety
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
