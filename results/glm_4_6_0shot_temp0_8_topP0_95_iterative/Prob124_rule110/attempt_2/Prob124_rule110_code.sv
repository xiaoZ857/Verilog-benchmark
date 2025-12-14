
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else begin
    // Calculate next state for all cells simultaneously
    reg [511:0] next_q;
    integer i;
    
    for (i = 0; i < 512; i = i + 1) begin
      reg left, center, right;
      left = (i == 511) ? 1'b0 : q[i+1];  // Right neighbor in array (left in table)
      center = q[i];                      // Current cell
      right = (i == 0) ? 1'b0 : q[i-1];   // Left neighbor in array (right in table)
      
      // Apply Rule 110
      case ({left, center, right})
        3'b111: next_q[i] = 1'b0;
        3'b110: next_q[i] = 1'b1;
        3'b101: next_q[i] = 1'b1;
        3'b100: next_q[i] = 1'b0;
        3'b011: next_q[i] = 1'b1;
        3'b010: next_q[i] = 1'b1;
        3'b001: next_q[i] = 1'b1;
        3'b000: next_q[i] = 1'b0;
      endcase
    end
    
    // Update all cells simultaneously
    q <= next_q;
  end
end

endmodule
