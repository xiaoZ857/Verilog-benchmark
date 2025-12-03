

module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

always @(posedge clk or negedge aresetn) begin
  if (!aresetn) begin
    z <= 0; // Reset the output to zero
  end else begin
    case (state) // State machine logic
      0: begin
        if (x == 1) begin
          state <= 1;
        end
        z <= 0; // Output remains unchanged in this state
      end
      1: begin
        if (x == 0) begin
          state <= 2;
        end else begin
          state <= 0; // Reset the state machine if input does not match expected value
          z <= 0; // Output remains unchanged in this state
        end
      end
      2: begin
        if (x == 1) begin
          state <= 0; // Reset the state machine and prepare for next sequence detection
          z <= 1; // Output is asserted when the "101" sequence is detected
        end else begin
          state <= 0; // Reset the state machine if input does not match expected value
          z <= 0; // Output remains unchanged in this state
        end
      end
    endcase
  end
end

// Initialization and sensitivity list
initial begin
  state <= 0; // Initialize the state to 0
end

// Define the state variable
reg [2:0] state;

// VERILOG-EVAL: endmodule not found
