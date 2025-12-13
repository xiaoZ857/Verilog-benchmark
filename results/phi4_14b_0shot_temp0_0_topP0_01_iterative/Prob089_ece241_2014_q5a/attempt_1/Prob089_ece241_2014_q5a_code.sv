
module TopModule (
  input clk,
  input areset,
  input x,
  output reg z
);

  // State encoding
  typedef enum logic [1:0] {
    IDLE = 2'b00,
    COMPLEMENT = 2'b01,
    DONE = 2'b10
  } state_t;

  state_t current_state, next_state;

  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    case (current_state)
      IDLE: begin
        z = 1'b0; // Default output in IDLE state
        if (!areset) begin
          next_state = COMPLEMENT;
        end else begin
          next_state = IDLE;
        end
      end

      COMPLEMENT: begin
        if (x == 1'b1) begin
          z = 1'b0; // Output '0' when first '1' is found
          next_state = DONE;
        end else begin
          z = ~x; // Complement the input bit
          next_state = COMPLEMENT;
        end
      end

      DONE: begin
        z = x; // Pass through remaining bits
        next_state = DONE;
      end

      default: begin
        z = 1'b0;
        next_state = IDLE;
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
