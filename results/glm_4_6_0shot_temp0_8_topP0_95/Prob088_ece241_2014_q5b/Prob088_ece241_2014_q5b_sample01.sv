
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

  // State encoding (one-hot)
  parameter [1:0] STATE_A = 2'b01;
  parameter [1:0] STATE_B = 2'b10;
  
  // State registers
  reg [1:0] state;
  reg [1:0] next_state;
  
  // Next state logic
  always @(*) begin
    case (state)
      STATE_A: begin
        if (x == 0) begin
          next_state = STATE_A;
        end else begin
          next_state = STATE_B;
        end
      end
      STATE_B: begin
        next_state = STATE_B;
      end
      default: next_state = STATE_A;
    endcase
  end
  
  // State register update
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= STATE_A;
    end else begin
      state <= next_state;
    end
  end
  
  // Output logic (Mealy machine - depends on current state and input)
  assign z = (state == STATE_A && x == 0) ? 1'b0 :
             (state == STATE_A && x == 1) ? 1'b1 :
             (state == STATE

// VERILOG-EVAL: endmodule not found
