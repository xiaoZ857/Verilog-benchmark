
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

  // Define states
  typedef enum logic [1:0] {
    A,
    B,
    C,
    D,
    E
  } state_t;

  reg state, next_state;

  // State register update
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    next_state = state; // Default: stay in the current state

    case (state)
      A: begin
        if (s == 1) begin
          next_state = B;
        end
      end
      B: begin
        if (w == 1) begin
          next_state = C;
        end else begin
          next_state = B;
        end
      end
      C: begin
        if (w == 1) begin
          next_state = D;
        end else begin
          next_state = B;
        end
      end
      D: begin
        if (w == 1) begin
          next_state = E;
        end else begin
          next_state = B;
        end
      end
      E: begin
        next_state = B;
      end
      default: begin
        next_state = A;
      end
    endcase
  end

  // Output logic
  always_comb begin
    if (state == E) begin
      z = 1;
    end else begin
      z = 0;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
