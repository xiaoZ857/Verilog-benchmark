

module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

always @(*) begin
    // Define the states of the state machine
    assign out = (j == 0) ? 0 : (k == 0) ? 1 : 0;
endmodule
