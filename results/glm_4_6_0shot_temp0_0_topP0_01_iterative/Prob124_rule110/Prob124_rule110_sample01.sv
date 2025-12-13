
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
    // Compute next state for each cell based on Rule 110
    integer i;
    reg [511:0] next_q;
    
    for (i = 0; i < 512; i = i + 1) begin
      // Get left, center, right values
      // Boundaries are 0
      reg left, center, right;
      
      if (i == 0) begin
        left = 1'b0;  // Left boundary
        center = q[0];
        right = q[1];
      end else if (i == 511) begin
        left = q[510];
        center = q[511];
        right = 1'b0;  // Right boundary
      end else begin
        left = q[i-1];
        center = q[i];
        right = q[i+1];
      end
      
      // Apply Rule 110
      // Next state is 1 for: 110, 101, 011, 010, 001
      // Next state is 0 for: 111, 100, 000
      next_q[i] = (left & center & ~right) |  // 110
                  (left & ~center & right) |  // 101
                  (~left & center & right) |  // 011
                  (~left & center & ~right) | // 010
                  (~left & ~center & right);  // 001
    end
    
    q <= next_q;
  end
end
endmodule
