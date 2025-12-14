
module TopModule (
  input wire clk,
  input wire in,
  input wire reset,
  output reg out
);

  // State encoding
  typedef enum logic [1:0] {
    A = 2'b00,  // State A
    B = 2'b01,  // State B
    C = 2'b10,  // State C
    D = 2'b11   // State D
  } state_t;

  // Registers to hold the current and next states
  reg [1:0] current_state;
  reg [1:0] next_state;

  // Combinational logic for next state calculation
  always @(*) begin
    case (current_state)
      A: next_state = in ? B : A; // From A, go to B if in=1 else stay at A
      B: next_state = in ? B : C; // From B, go to B if in=1 else go to C
      C: next_state = in ? D : A; // From C, go to D if in=1 else go to A
      D: next_state = in ? B : C; // From D, go to B if in=1 else go to C
      default: next_state = A;
    endcase
  end

  // Sequential logic for state transition and output generation
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= A; // Reset to state A
    end else begin
      current_state <= next_state; // Transition to the next state
    end
  end

  // Output logic based on the Moore output function
  always @(*) begin
    case (current_state)
      A: out = 0;
      B: out = 0;
      C: out = 0;
      D: out = 1;
      default: out = 0; // Default case to handle unexpected states
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
