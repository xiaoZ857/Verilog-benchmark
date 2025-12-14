
module TopModule (
  input wire clk,
  input wire reset,
  input wire x,
  input wire y,
  output reg z
);

  // State encoding
  typedef enum logic [2:0] {
    S1,  // z = 1, x and y are irrelevant
    S2,  // z = 0, wait for x to be high
    S3,  // z = 0, wait for x to be low after it has been high
    S4   // z = 1, detect when both x and y are high
  } state_t;

  state_t current_state, next_state;

  always_ff @(posedge clk or posedge reset) begin
    if (reset)
      current_state <= S1;
    else
      current_state <= next_state;
  end

  always_comb begin
    // Default behavior: hold the current output unless a transition is necessary
    case (current_state)
      S1: begin
        z = 1'b1;
        if (!x) begin
          next_state = S2;
        end else if (x && y) begin
          next_state = S4;
        end else begin
          next_state = S1;
        end
      end

      S2: begin
        z = 1'b0;
        if (x) begin
          next_state = S3;
        end else begin
          next_state = S2; // Stay in state S2 until x is high
        end
      end

      S3: begin
        z = 1'b0;
        if (!x && y) begin
          next_state = S4;
        end else if (!x) begin
          next_state = S1;
        end else begin
          next_state = S3; // Stay in S3 until x is low again
        end
      end

      S4: begin
        z = 1'b1;
        if (!x || !y) begin
          next_state = S1;
        end else begin
          next_state = S4; // Remain in state S4 as long as both x and y are high
        end
      end

      default: begin
        z = 1'bx;
        next_state = S1;
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
