
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
// Internal registers to store the current and previous state of 'in'
reg [7:0] prev_in;
reg [7:0] transition_detected;

always @(posedge clk) begin
    // Detect 0 to 1 transitions for each bit
    transition_detected <= (prev_in & ~in); // Set bits where prev_in was 0 and in is now 1

    // Update the previous state register with the current input
    prev_in <= in;

    // Set pedge one cycle after a transition is detected
    pedge <= transition_detected;
end

endmodule
