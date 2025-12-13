
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);

  // State encoding
  parameter [2:0] A = 3'b000;
  parameter [2:0] B = 3'b001;
  parameter [2:0] C = 3'b010;
  parameter [2:0] D = 3'b011;
  parameter [2:0] E = 3'b100;
  parameter [2:0] F = 3'b101;
  
  // State registers
  reg [2:0] current_state, next_state;
  
  // State flip-flops
  always @(posedge clk) begin
    if (reset) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end
  
  // Next state logic
  always @(*) begin
    case (current_state)
      A: begin
        if (w) next_state = B;
        else next_state = A;
      end
      B: begin
        if (w) next_state = C;
        else next_state = D;
      end
      C: begin
        if (w) next_state = E;
        else next_state = D;
      end
      D: begin
        if (w) next_state = F;
        else next_state = A;
      end
      E: begin
        if (w) next_state = E;
        else next_state = D;
      end
      F: begin
        if (w) next_state = C;
        else next_state = D;
      end
      default: next_state = A;
    endcase
  end
  
  // Output logic
  assign z = (current_state == E) || (current_state == F);
  
endmodule
