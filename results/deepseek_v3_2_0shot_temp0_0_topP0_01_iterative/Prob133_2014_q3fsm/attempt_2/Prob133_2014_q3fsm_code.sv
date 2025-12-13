
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
  reg [1:0] state, next_state;
  reg [1:0] count, next_count;
  reg z_next;
  
  localparam A  = 2'b00;
  localparam B0 = 2'b01;
  localparam B1 = 2'b10;
  localparam B2 = 2'b11;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= A;
      count <= 2'b00;
      z <= 1'b0;
    end else begin
      state <= next_state;
      count <= next_count;
      z <= z_next;
    end
  end
  
  always @(*) begin
    next_state = state;
    next_count = count;
    z_next = 1'b0;
    
    case (state)
      A: begin
        if (s) begin
          next_state = B0;
          next_count = (w) ? 2'b01 : 2'b00;
        end
      end
      B0: begin
        next_state = B1;
        next_count = (w) ? count + 2'b01 : count;
      end
      B1: begin
        next_state = B2;
        next_count = (w) ? count + 2'b01 : count;
      end
      B2: begin
        // Check if count equals 2 (exactly two w=1 in the window)
        // Set z_next for the next cycle (after the window ends)
        z_next = (count == 2'b10);
        
        // Start next window
        next_state = B0;
        next_count = (w) ? 2'b01 : 2'b00;
      end
      default: next_state = A;
    endcase
  end
endmodule
