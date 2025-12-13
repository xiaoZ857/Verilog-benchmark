
module TopModule (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State definition
    typedef enum {
        S000 = 3'b000,
        S001 = 3'b001,
        S010 = 3'b010,
        S011 = 3'b011,
        S100 = 3'b100
    ) state_t;

    reg [2:0] y;  // Current state
    reg x;         // Input

    always @(posedge clk) begin
        if (reset) begin
            y <= S000;
        end else begin
            case (y)
                S000:
                   

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
