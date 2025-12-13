
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
  reg [1:0] state, next_state;
  reg [1:0] count, next_count;
  reg [1:0] prev_count_for_z;
  reg z_next;
  
  localparam A  = 2'b00;
  localparam B0 = 2'b01;
  localparam B1 = 2'b10;
  localparam B2 = 2'b11;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= A;
      count <= 2'b00;
      prev_count_for_z <= 2'b00;
      z <= 1'b0;
    end else begin
      state <= next_state;
      count <= next_count;
      // Store count at the end of a window to use for z next cycle
      if (state == B2) begin
        prev_count_for_z <= next_count;
      end
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
        next_state = B0;
        next_count = (w) ? 2'b01 : 2'b00; // reset count for new window, starting with this w
        // z for previous window is set now (one cycle after window ends)
        z_next = (prev_count_for_z == 2'b10);
      end
      default: next_state = A;
    endcase
  end
endmodule
