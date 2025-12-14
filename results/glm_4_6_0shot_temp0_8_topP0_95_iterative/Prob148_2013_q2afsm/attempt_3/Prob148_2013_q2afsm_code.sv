
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  // State encoding
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  // State registers
  reg [1:0] current_state, next_state;
  
  // Output register
  reg [3:1] g;
  
  // State transition logic
  always @(*) begin
    case (current_state)
      A: begin
        if (r[1]) next_state = B;
        else if (r[2]) next_state = C;
        else if (r[3]) next_state = D;
        else next_state = A;
      end
      B: begin
        if (r[1]) next_state = B;
        else next_state = A;
      end
      C: begin
        if (r[2]) next_state = C;
        else next_state = A;
      end
      D: begin
        if (r[3]) next_state = D;
        else next_state = A;
      end
      default: next_state = A;
    endcase
  end
  
  // State flip-flops
  always @(posedge clk) begin
    if (!resetn) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end
  
  // Output logic
  always @(*) begin
    g = 3'b000;  // Default: no grants
    case (current_state)
      B: g[1] = 1'b1;  // Grant to device 1
      C: g[2] = 1'b1;  // Grant to device 2
      D: g[3] = 1'b1;  // Grant to device 3
      default: g = 3'b000;  // No grants in state A or other states
    endcase
  end

endmodule
