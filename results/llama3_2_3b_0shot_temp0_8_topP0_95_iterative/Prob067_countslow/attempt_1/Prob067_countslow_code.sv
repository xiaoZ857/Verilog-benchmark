
// Define the module and its inputs/outputs
module TopModule(
  input clk,     // Positive clock/clk triggered
  input slowena,  // Active low signal to pause increment
  input reset,    // Active high synchronous reset
  output reg [3:0] q  // Output register representing the decade counter
);

// Declare a variable to keep track of the current count
reg [9:0] count = 0;

// Wire the outputs directly to the signal they represent
assign q = count[7:4];

// Create an always block to handle the clock and reset events
always @(posedge clk or posedge slowena or negedge reset)
begin

  // Reset the counter on a rising edge of the reset input
  if (reset) begin
    count <= 0;
  end 
  // Increment the counter when slowena goes low
  else if (slowena == 0) begin
    count <= count + 1;
  end 
  // Increment the counter only on a rising edge of the clock input
  else if (clk == 1) begin
    count <= count + 1;
  end 

end

// End module definition
endmodule

// VERILOG-EVAL: errant inclusion of module definition
