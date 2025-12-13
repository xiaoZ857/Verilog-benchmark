
module TopModule (
  input wire clk,
  input wire areset,
  input wire [1:0] x,
  output reg [1:0] z
);

reg [31:0] data; // To store the incoming bits
reg [1:0] state; // Current state of the FSM

// Initialization and reset
always @(posedge clk or negedge areset) begin
  if (areset) begin
    data <= 0;
    state <= 1'b0;
  end
end

// State machine for processing incoming bits
always @(posedge clk) begin
  case (state)
    1'b0: begin // Waiting for the first bit
      if (!areset && x[0]) begin
        data <= {x, data}; // Shift the incoming bit to the left and store it
        state <= 2'b10; // Transition to the next state
      end
    end
    2'b10: begin // Accumulating bits
      if (x[0]) begin
        data <= {x, data}; // Shift the incoming bit to the left and store it
      end
      state <= state + 1; // Move to the next state
    end
    2'b11: begin // Complementing the stored bits
      z <= ~data;
      state <= 1'b0; // Reset the state machine for the next number
    end
    default: state <= 1'b0; // If an invalid state is reached, reset the FSM
  endcase
end

// Output enable
assign output_enable = ~areset || (state != 2'b11);

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
