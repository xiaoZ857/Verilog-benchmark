
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
reg [2:0] nextState = initialState;
wire z;

always @(posedge clk) begin
    if (x == 0 && y[2:0] != nextState)
        nextState = nextState10;
    else if (x == 0 && y[2:0] == nextState)
        nextState = nextState01;
    else if (x == 1 && y[2:0] != nextState)
        nextState = nextState11;
    else if (x == 1 && y[2:0] == nextState)
        nextState = nextState10;

    // Calculate the output z based on the current state
    assign z = {nextState[1], nextState[0]};
end

assign Y0 = nextState;

endmodule
