
module TopModule (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err
);

reg [5:0] state_machine; // State machine register
always @(posedge clk) begin
  if (reset) begin
    state_machine <= 0; // Reset the state machine to the initial state
  end else begin
    case (state_machine)
      0: begin
        if (in == 1'b1) begin
          state_machine <= 1; // Move to the next state
        end
      end,
      1: begin
        if (in == 1'b0) begin
          state_machine <= 2; // Move to the next state
        end else if (in == 1'b1 && state_machine[4] == 1'b1) begin
          state_machine <= 3; // Move to the error state
        end
      end,
      2: begin
        state_machine[0] <= in; // Store the current input bit
        if (in == 1'b1) begin
          state_machine <= {state_machine[4], 1'b1}; // Move to the next state and store the new bit
        end
      end,
      3: begin
        if (in == 1'b0) begin
          state_machine <= 2; // Move back to the data state and discard the error bit
          disc <= 1'b1; // Signal that a bit needs to be discarded
        end else if (state_machine[4] == 1'b1 && in == 1'b1) begin
          state_machine <= {state_machine[3], 1'b0}; // Move to the flag state and store the new bit
          flag <= 1'b1; // Signal that a frame boundary has been detected
        end else if (in == 1'b1 && state_machine[4] == 1'b0) begin
          state_machine <= {state_machine[3], 1'b1}; // Store the new bit and move to the error state
          err <= 1'b1; // Signal an error
        end
      end,
      default: state_machine <= 0; // Reset the state machine if an invalid state is encountered
    endcase
  end
end

always @(posedge clk) begin
  disc <= ~state_machine[0]; // Output the bit that needs to be discarded
  flag <= ~state_machine[4]; // Output the flag indicating a frame boundary
  err <= ~state_machine[5]; // Output the error signal
end

// Initialization block for synthesis tools
initial begin
  state_machine <= 0;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
