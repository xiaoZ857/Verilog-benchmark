
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);

  // Define states
  parameter A = 2'b00
  parameter B = 2'b01
  parameter C = 2'b10
  parameter D = 2'b11

  // State register
  reg [1:0] current_state;

  // Synchronous reset
  always @(posedge clk) begin
    if (areset) begin
      current_state <= A;
    end else begin
      case (current_state)
        A: begin
          if (in == 0) begin
            current_state <= A;
          end else begin
            current_state <= B;
          end
        end
        B: begin
          if (in == 0) begin
            current_state <= C;
          end else begin
            current_state <= B;
          end
        end
        C: begin
          if (in == 0) begin
            current_state <= A;
          end else begin
            current_state <= D;
          end
        end
        D: begin
          if (in == 0) begin
            current_state <= C;
          end else begin
            current_state <= B;
          end
        end
        default: begin
          current_state <= A; // Should never happen, but good practice
        end
      endcase
    end
  end

  // Output logic
  always @(current_state) begin
    case (current_state)
      A: out = 0;
      B: out = 0;
      C: out = 0;
      D: out = 1;
      default: out = 0; // Default to 0 if state is undefined
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
