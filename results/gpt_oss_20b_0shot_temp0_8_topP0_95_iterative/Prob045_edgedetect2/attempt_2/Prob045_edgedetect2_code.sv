
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);
reg [7:0] prev;   // Holds the input from the previous clock cycle

always_ff @(posedge clk) begin
    // Detect a change on any bit: XOR with the previous value
    anyedge <= in ^ prev;
    // Update the previous value for the next cycle
    prev <= in;
end

endmodule
