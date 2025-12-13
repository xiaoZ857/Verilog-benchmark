
module TopModule (
  input wire clk,
  input wire in,
  input wire reset,
  output reg out
);

  // State encoding
  typedef enum logic [1:0] {
    A = 2'b00,
    B = 2'b01,
    C = 2'b10,
    D = 2'b11
  } state_t;

  // Declare the current and next state registers
  state_t current_state, next_state;

  // State transition logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= A; // Reset to state A
    end else begin
      current_state <= next_state;
    end
  end

  // Next state and output logic
  always_comb begin
    case (current_state)
      A: begin
        next_state = in ? B : A;
        out = 1'b0; // Explicitly cast to 1-bit logic
      end
      B: begin
        next_state = in ? B : C;
        out = 1'b0; // Explicitly cast to 1-bit logic
      end
      C: begin
        next_state = in ? D : A;
        out = 1'b0; // Explicitly cast to 1-bit logic
      end
      D: begin
        next_state = in ? B : C;
        out = 1'b1; // Explicitly cast to 1-bit logic
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
