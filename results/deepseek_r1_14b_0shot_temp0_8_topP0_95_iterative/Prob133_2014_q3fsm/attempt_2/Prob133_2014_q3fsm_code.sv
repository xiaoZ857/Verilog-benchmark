
$timescale 1ns / 1ps

module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg state;    // State definition: 0 = A, 1 = B, 2 = C, 3 = D
reg [1:0] cnt; // Counter to track number of consecutive w=1

// Main state machine logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    cnt <= 0;
  end else case (state) begin
    0: begin   // State A
      if (s == 1) begin
        state <= 1;  // Move to state B when s=1
      end
    end
    1: begin   // State B (beginning of w checking window)
      state <= 2;
    end
    2: begin   // State C (second cycle of w checking)
      state <= 3;
    end
    3: begin   // State D (third and final cycle of w checking)
      if (w == 1) cnt <= 2;  // If w=1 in third cycle, set z to 1 next cycle
      else        cnt <= 0;  // Otherwise reset counter
      state <= 0;            // Return to state A after three cycles
    end
    default: begin
      state <= 0;
    end
  endcase
end

// Output logic based on state and counter
always @(posedge clk) begin
  case (state) begin
    0,1,2: z <= 0; // Outside of w checking window, z=0
    3: begin
      if (cnt == 2) z <= 1;
      else           z <= 0;
    end
  endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
