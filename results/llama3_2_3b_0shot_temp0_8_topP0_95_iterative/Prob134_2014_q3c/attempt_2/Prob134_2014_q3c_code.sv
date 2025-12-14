
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
// Initialize the next state with the initial state
reg [2:0] nextState = initialState;
wire [1:0] z;

always @(posedge clk) begin
    if (x == 1 && y[2:0] != nextState)
        nextState = nextState10;
    else if (y[2:0] == nextState)
        nextState = nextState01;

    // Calculate the output z based on the current state
    assign z = {nextState[1], nextState[0]};
end

assign Y0 = nextState;

endmodule
