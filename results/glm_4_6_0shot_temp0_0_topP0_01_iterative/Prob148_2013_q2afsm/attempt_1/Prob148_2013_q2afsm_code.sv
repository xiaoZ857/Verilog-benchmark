
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  // State encoding
  localparam [1:0] STATE_A = 2'b00,
                   STATE_B = 2'b01,
                   STATE_C = 2'b10,
                   STATE_D = 2'b11;
  
  reg [1:0] current_state, next_state;
  
  // State flip-flops
  always @(posedge clk) begin
    if (!resetn) begin
      current_state <= STATE_A;
    end else begin
      current_state <= next_state;
    end
  end
  
  // Next state logic
  always @(*) begin
    case (current_state)
      STATE_A: begin
        if (r[1]) begin
          next_state = STATE_B;
        end else if (r[2]) begin
          next_state = STATE_C;
        end else if (r[3]) begin
          next_state = STATE_D;
        end else begin
          next_state = STATE_A;
        end
      end
      
      STATE_B: begin
        if (r[1]) begin
          next_state = STATE_B;
        end else begin
          next_state = STATE_A;
        end
      end
      
      STATE_C: begin
        if (r[2]) begin
          next_state = STATE_C;
        end else begin
          next_state = STATE_A;
        end
      end
      
      STATE_D: begin
        if (r[3]) begin
          next_state = STATE_D;
        end else begin
          next_state = STATE_A;
        end
      end
      
      default: begin
        next_state = STATE_A;
      end
    endcase
  end
  
  // Output logic

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
