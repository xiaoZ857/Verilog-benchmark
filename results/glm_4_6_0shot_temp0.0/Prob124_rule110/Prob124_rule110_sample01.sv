
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
      for (i = 0; i < 512; i = i + 1) begin
        // Get left, center, and right values
        // For boundaries, assume out-of-bounds cells are 0
        reg left, center, right;
        
        if (i == 511) begin
          left = 1'b0;  // q[512] doesn't exist, assume 0
        end else begin
          left = q[i + 1];
        end
        
        center = q[i];
        
        if (i == 0) begin
          right = 1'b0;  // q[-1] doesn't exist, assume 0
        end else begin
          right = q[i - 1];
        end
        
        // Apply Rule 110 truth table
        case ({left, center, right})
          3'b111: q[i] <= 1'b0;
          3'b110: q[i] <= 1'b1;
          3'b101: q[i] <= 1'b1;
          3'b100: q[i] <= 1'b0;
          3'b011: q[i] <= 1'b1;
          3'b010: q[i] <= 1'b1;
          3'b001: q[i] <= 1'b1;
          3'b000: q[i] <= 1'b0;
        endcase
      end
    end
  end
endmodule
