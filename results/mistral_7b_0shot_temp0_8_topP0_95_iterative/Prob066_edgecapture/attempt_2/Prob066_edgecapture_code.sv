
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
reg [31:0] prevIn;

always @(posedge clk or negedge reset) begin
    if (reset) begin
        out <= 32'b0; // reset all output bits
    end else if (~prevIn[i] && in[i]) begin // Check for a transition from 1 to 0
        out[i] <= 1'b1; // Set the corresponding output bit when transition happens
    end
    prevIn <= in; // store current input value for next clock cycle
end

endmodule
