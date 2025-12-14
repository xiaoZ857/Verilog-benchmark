
module TopModule (
    input  wire [2:0] a,
    output reg  [15:0] q
);
    // ----------------------------------------------------
    //  Combinational logic – ROM style case statement
    // ----------------------------------------------------
    always @(*) begin
        case (a)
            3'b000 : q = 16'h1232;   // a = 0
            3'b001 : q = 16'hAEE0;   // a = 1
            3'b010 : q = 16'h27D4;   // a = 2
            3'b011 : q = 16'h5A0E;   // a = 

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
