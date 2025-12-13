
module TopModule(
    input clk, // Positive clock/clk triggered signal
    input x,     // Input signal
    input [2:0] y, // Present state input
    output reg Y0, // Output of Y[0]
    output reg z   // Output of z
);

reg [3:0] nextState; // Next state

always @(posedge clk) begin // Clock edge triggered
    if (x == 0) begin // x=0 case
        nextState = y;
    else if (x == 1) begin // x=1 case
        nextState = {y[2], y[1], y[0] + 1, 0}; // Assign the last bit to 0
    end

    Y0 <= nextState[0]; // Assign output of Y[0]
    z <= nextState[3]; // Assign output of z
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
