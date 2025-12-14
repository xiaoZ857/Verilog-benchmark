
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  // Advance one time step on each rising clock edge.
  // Load `data` into `q` when `load` is high.
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      reg [511:0] next;        // Temporary register for next state
      integer i;
      for (i = 0; i < 512; i = i + 1) begin
        // Determine left, center, right neighbors
        // Boundaries are treated as logic 0
        logic left, center, right;
        left   = (i == 511) ? 1'b0 : q[i+1];
        center = q[i];
        right  = (i == 0)   ? 1'b0 : q[i-1];

        // Apply Rule‑110 truth table
        case ({left, center, right})
          3'b111: next[i] = 1'b0;
          3'b110: next[i] = 1'b1;
          3'b101: next[i] = 1'b1;
          3'b100: next[i] = 1'b0;
          3'b011: next[i] = 1'b1;
          3'b010: next[i] = 1'b1;
          3'b001: next[i] = 1'b1;
          3'b000: next[i] = 1'b0;
          default: next[i] = 1'b0; // Should never occur
        endcase
      end
      q <= next;
    end
  end

endmodule
