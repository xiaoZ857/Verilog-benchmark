
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

  // State encoding for 2's complementer Moore machine
  localparam S_WAIT = 1'b0;  // Waiting for first '1', output equals input
  localparam S_INVERT = 1'b1;  // After first '1', output is inverted input
  
  reg state;
  reg z_reg;
  
  // Moore state machine
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= S_WAIT;
      z_reg <= 1'b0;
    end else begin
      case (state)
        S_WAIT: begin
          if (x == 1'b1) begin
            state <= S_INVERT;
            z_reg <= 1'b1;  // First 1 stays as 1
          end else begin
            state <= S_WAIT;
            z_reg <= 1'b0;  // 0 stays as 0
          end
        end
        
        S_INVERT: begin
          state <= S_INVERT;  // Stay in invert state
          z_reg <= ~x;  // Invert all subsequent bits
        end
        
        default: begin
          state <= S_WAIT;
          z_reg <= 1'b0;
        end
      endcase
    end
  end
  
  assign z = z_reg;
  
endmodule
