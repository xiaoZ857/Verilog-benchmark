
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

  // Define states using one-hot encoding
  localparam STATE_A = 2'b00;
  localparam STATE_B = 2'b01;

  // State register
  reg [1:0] current_state;

  // Output register
  reg z;

  // Synchronous logic (clocked by clk)
  always @(posedge clk) begin
    if (areset) begin
      current_state <= STATE_A;
      z <= 0;
    end else begin
      case (current_state)
        STATE_A: begin
          if (x) begin
            current_state <= STATE_B;
            z <= 0;
          end else begin
            current_state <= STATE_A;
            z <= 0;
          end
        end
        STATE_B: begin
          if (x) begin
            current_state <= STATE_B;
            z <= 0;
          end else begin
            current_state <= STATE_B;
            z <= 1;
          end
        end
        default: begin
          current_state <= STATE_A;
          z <= 0;
        end
      endcase
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
