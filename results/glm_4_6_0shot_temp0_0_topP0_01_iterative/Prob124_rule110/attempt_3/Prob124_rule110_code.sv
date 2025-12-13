
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
    // Compute next state for all cells
    reg [511:0] next_q;
    integer i;
    
    for (i = 0; i < 512; i = i + 1) begin
      reg left, center, right;
      
      // Get left neighbor (0 for boundary)
      if (i == 0) begin
        left = 1'b0;
      end else begin
        left = q[i-1];
      end
      
      // Get center
      center = q[i];
      
      // Get right neighbor (0 for boundary)
      if (i == 511) begin
        right = 1'b0;
      end else begin
        right = q[i+1];
      end
      
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
        default: next_q[i] = 1'b0;
      endcase
    end
    
    q <= next_q;
  end
end
endmodule
