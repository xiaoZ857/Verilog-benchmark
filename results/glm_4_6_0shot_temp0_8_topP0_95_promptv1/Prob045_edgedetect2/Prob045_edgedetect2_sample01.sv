
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

  reg [7:0] prev_in;
  
  always @(posedge clk) begin
    // Store previous input value
    prev_in <= in;
    
    // Detect any edge (change from previous cycle)
    // XOR will be 1 when bits are different (0→1 or 1→0)
    anyedge <= in ^ prev_in;
  end
endmodule
