
module TopModule (
  input clk, // Positive clock/clk triggered signal
  input x,
  input y,
  output reg [1:0] z // Reg to hold the current value of z
);

reg [2:0] state; // State variable

always @(posedge clk)
begin
    if (state == 3'b000) // If in state 000
        if (!x && !y) // If x and y are both low
            z <= 3'b100; // Set z to 1,0,0
        else if (x) // If x is high
            z <= 3'b010; // Set z to 0,1,0
        else
            z <= 3'b000; // Otherwise set z to 0,0,0

    else if (state == 3'b001) // If in state 001
        if (!x && !y) // If x and y are both low
            z <= 3'b100; // Set z to 1,0,0
        else if (y) // If y is high
            z <= 3'b010; // Set z to 0,1,0
        else
            z <= 3'b001; // Otherwise set z to 0,0,1

    else if (state == 3'b010) // If in state 010
        if (!x && !y) // If x and y are both low
            z <= 3'b100; // Set z to 1,0,0
        else if (x && y) // If both x and y are high
            z <= 3'b111; // Set z to 1,1,1
        else
            z <= 3'b010; // Otherwise set z to 0,1,0

    else if (state == 3'b011) // If in state 011
        if (!x && !y) // If x and y are both low
            z <= 3'b100; // Set z to 1,0,0
        else if (x || y) // If either x or y is high
            z <= 3'b111; // Set z to 1,1,1
        else
            z <= 3'b011; // Otherwise set z to 0,0,1

    else if (state == 3'b100) // If in state 100
        if (!x && !y) // If x and y are both low
            z <= 3'b000; // Set z to 0,0,0
        else if (!x || !y) // If either x or y is low
            z <= 3'b010; // Set z to 0,1,0
        else
            z <= 3'b111; // Otherwise set z to 1,1,1

    else if (state == 3'b101) // If in state 101
        if (!x && !y) // If x and y are both low
            z <= 3'b000; // Set z to 0,0,0
        else if (x || y) // If either x or y is high
            z <= 3'b010; // Set z to 0,1,0
        else
            z <= 3'b101; // Otherwise set z to 0,0,1

    else if (state == 3'b110) // If in state 110
        if (!x && !y) // If x and y are both low
            z <= 3'b000; // Set z to 0,0,0
        else if (!x || !y) // If either x or y is low
            z <= 3'b101; // Set z to 0,0,1
        else
            z <= 3'b111; // Otherwise set z to 1,1,1

    else if (state == 3'b111) // If in state 111
        if (!x && !y) // If x and y are both low
            z <= 3'b000; // Set z to 0,0,0
        else if (!x || !y) // If either x or y is low
            z <= 3'b010; // Set z to 0,1,0
        else
            z <= 3'b100; // Otherwise set z to 1,0,0

    state = state + 1; // Increment the state variable on each clk edge
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
