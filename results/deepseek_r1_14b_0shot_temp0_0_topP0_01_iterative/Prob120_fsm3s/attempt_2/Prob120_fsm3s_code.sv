
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

  // State definition (2 bits for 4 states: A=00, B=01, C=10, D=11)
  typedef enum {A=0, B=1, C=2, D=3} state_t;
  state_t current_state, next_state;

  // Output logic based on current state
  assign out = (current_state == D) ? 1 : 0;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= A;
    end else begin
      case (current_state)
        A: 
          if (in == 0) next_state = A;
          else          next_state = B;
        B:
          if (in == 0) next_state = C;
          else          next_state = B;
        C:
          if (in == 0) next_state = A;
          else          next_state = D;
        D:
          if (in == 0) next_state = C;
          else          next_state = B;
      endcase
      current_state <= next_state;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
