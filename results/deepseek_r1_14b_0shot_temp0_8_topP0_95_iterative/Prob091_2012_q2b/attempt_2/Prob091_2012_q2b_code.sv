
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

always @(*) begin
  case (y)
    // State A (000001): y[0] is 1
    6'b000001: begin
      if (w == 1) begin
        Y1 = 1;  // Next state B sets y[1]
      end else begin
        Y1 = 0;
      end
      Y3 = 0;   // Stay in A, D not set
    end
    
    // State B (000010): y[1] is 1
    6'b000010: begin
      if (w == 1) begin
        Y1 = 0;  // Next state C doesn't affect y[1]
      end else begin
        Y1 = 1;   // Stay in B, so y[1] remains set
      end
      Y3 = 0;
    end
    
    // State C (000100): y[2] is 1
    6'b000100: begin
      if (w == 1) begin
        Y1 = 0;  // Next state E doesn't affect y[1]
      end else begin
        Y1 = 0;   // Go to D, which sets y[3]
      end
      if (!w) begin
        Y3 = 1;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
