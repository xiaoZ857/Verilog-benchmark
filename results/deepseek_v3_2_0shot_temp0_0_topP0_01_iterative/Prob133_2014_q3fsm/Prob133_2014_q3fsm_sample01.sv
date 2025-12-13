
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
  always @(posedge clk) begin
    if (reset) begin
      state <= A;
      count <= 2'b00;
      cycle <= 2'b00;
      z <= 1'b0;
    end else begin
      state <= next_state;
      count <= next_count;
      cycle <= next_cycle;
      z <= z_next;
    end
  end
  
  always @(*) begin
    next_state = state;
    next_count = count;
    next_cycle = cycle;
    z_next = 1'b0;
    
    case (state)
      A: begin
        if (s) begin
          next_state = B;
          next_count = (w) ? 2'b01 : 2'b00;
          next_cycle = 2'b01;
        end
      end
      B: begin
        if (cycle == 2'b11) begin
          // End of 3-cycle window
          z_next = (count == 2'b10);
          // Start next window
          next_count = (w) ? 2'b01 : 2'b00;
          next_cycle = 2'b01;
        end else begin
          // Still counting within window
          next_count = (w) ? count + 2'b01 : count;
          next_cycle = cycle + 2'b01;
        end
      end
      default: begin
        next_state = A;
        next_count = 2'b00;
        next_cycle = 2'b00;
      end
    endcase
  end
endmodule
