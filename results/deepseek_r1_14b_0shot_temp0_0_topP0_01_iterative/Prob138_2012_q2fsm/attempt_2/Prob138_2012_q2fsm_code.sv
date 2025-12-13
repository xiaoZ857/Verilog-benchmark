
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);

  // State definitions
  typedef enum {
    A = 0,
    B = 1,
    C = 2,
    D = 3,
    E = 4,
    F = 5
  ) state_type;

  reg [2:0] current_state, next_state;
  wire input_w;

  // State transition table
  always @* 
    case (current_state)
      A:
        if (w == 1) next_state = B;
        else          next_state = A;
      B:
        if (w == 1) next_state = C;
        else          next_state = D;
      C:
        if (w == 1) next_state = E;
        else          next_state = D;
      D:
        if (w == 1) next_state = F;
        else          next_state = A;
      E:
        if (w == 1) next_state = E;
        else          next_state = D;
      F:
        if (w == 1) next_state = C;
        else          next_state = D;
      default:
        next_state = A;
    endcase

  // State flip-flops
  always @ (posedge clk or posedge reset)
    if (reset)
      current_state <= A;
    else
      current_state <= next_state;

  // Output definition
  assign z = (current_state == E) ? 1 : 0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
