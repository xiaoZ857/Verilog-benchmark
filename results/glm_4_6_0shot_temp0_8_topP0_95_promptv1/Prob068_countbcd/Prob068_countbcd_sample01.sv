
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

  always @(posedge clk) begin
    if (reset) begin
      q <= 16'h0000;
    end else begin
      // Ones digit (always increment)
      if (q[3:0] == 4'h9)
        q[3:0] <= 4'h0;
      else
        q[3:0] <= q[3:0] + 4'h1;
      
      // Tens digit (increment when ones rolls over)
      if (q[3:0] == 4'h9) begin
        if (q[7:4] == 4'h9)
          q[7:4] <= 4'h0;
        else
          q[7:4] <= q[7:4] + 4'h1;
      end
      
      // Hundreds digit (increment when tens rolls over)
      if ((q[3:0] == 4'h9) && (q[7:4] == 4'h9)) begin
        if (q[11:8] == 4'h9)
          q[11:8] <= 4'h0;
        else
          q[11:8] <= q[11:8] + 4'h1;
      end
      
      // Thousands digit (increment when hundreds rolls over)
      if ((q[3:0] == 4'h9) && (q[7:4] == 4'h9) && (q[11:8] == 4'h9)) begin
        if (q[15:12] == 4'h9)
          q[15:12] <= 4'h0;
        else
          q[15:12] <= q[15:12] + 4'h1;
      end
    end
  end
  
  // Enable signals for upper three digits
  assign ena[1] = (q[3:0] == 4'h9);
  assign ena[2] = (q[3:0] == 4'h9) && (q[7:4] == 4'h9);
  assign ena[3] = (q[3:0] == 4'h9) && (q

// VERILOG-EVAL: endmodule not found
