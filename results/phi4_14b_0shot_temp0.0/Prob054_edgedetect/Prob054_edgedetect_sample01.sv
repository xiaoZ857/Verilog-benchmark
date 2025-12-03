

module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
    // Shift the previous input to current state for comparison
    prev_in <= in;
    
    // Detect positive edge (0 -> 1 transition)
    pedge <= (prev_in & ~in);
end

endmodule
