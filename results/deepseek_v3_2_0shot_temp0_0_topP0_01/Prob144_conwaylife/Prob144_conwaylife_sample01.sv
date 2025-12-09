
module TopModule (
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);
  wire [255:0] next_q;
  genvar i, j;
  generate
    for (i = 0; i < 16; i = i + 1) begin : row_loop
      for (j = 0; j < 16; j = j + 1) begin : col_loop
        // Neighbor coordinates with wrap-around
        wire [3:0] row_above = (i == 0) ? 4'd15 : (i - 1);
        wire [3:0] row_below = (i == 15) ? 4'd0 : (i + 1);
        wire [3:0] col_left  = (j == 0) ? 4'd15 : (j - 1);
        wire [3:0] col_right = (j == 15) ? 4'd0 : (j + 1);
        
        // Extract neighbor values
        wire nw = q[row_above * 16 + col_left];
        wire n  = q[row_above * 16 + j];
        wire ne = q[row_above * 16 + col_right];
        wire w  = q[i * 16 + col_left];
        wire e  = q[i * 16 + col_right];
        wire sw = q[row_below * 16 + col_left];
        wire s  = q[row_below * 16 + j];
        wire se = q[row_below * 16 + col_right];
        
        // Count live neighbors
        wire [3:0] neighbor_count = nw + n + ne + w + e + sw + s + se;
        
        // Next state logic
        assign next_q[i*16 + j] = 
          (neighbor_count == 2) ? q[i*16 + j] :
          (neighbor_count == 3) ? 1'b1 :
          1'b0;
      end
    end
  endgenerate
  
  always @(posedge clk) begin
    if (load)
      q <= data;
    else
      q <= next_q;
  end
endmodule
