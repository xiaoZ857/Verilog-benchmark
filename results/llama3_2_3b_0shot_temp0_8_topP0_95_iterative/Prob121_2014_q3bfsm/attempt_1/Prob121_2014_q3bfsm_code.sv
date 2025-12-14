
module TopModule(
    input clk,
    input reset,
    input x,
    output [2:0] reg z
);

reg [2:0] currentState;

initial value = 3'b000;
currentState <= value;

always @(posedge clk)
begin
    if(reset == 1) 
        currentState <= 3'b000;
    else if(x == 0)
        currentState <= 3'b001;
    else if(x == 1)
        currentState <= 3'b010;
    else if(x == 2)
        if(currentState == 3'b001 || currentState == 3'b011)
            z <= 3'b000;
        else
            z <= 3'b001;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
