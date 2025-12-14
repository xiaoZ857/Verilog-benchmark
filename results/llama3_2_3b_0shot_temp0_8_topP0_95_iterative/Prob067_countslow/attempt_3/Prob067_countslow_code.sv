
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
begin

  // Reset the counter on a rising edge of the reset input
  if (reset) begin
    count <= 0;
  end 
  // Increment the counter when slowena goes high AND it's not currently incrementing
  else if (~slowena && (count == 9)) begin
    count <= 0; // Reset to 0 after reaching 9
  elsif (~slowena) begin
    count <= count + 1;
  end 

end

// VERILOG-EVAL: endmodule not found
