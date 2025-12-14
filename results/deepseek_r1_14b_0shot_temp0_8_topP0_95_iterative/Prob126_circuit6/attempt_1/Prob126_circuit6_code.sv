
module TopModule (
    input [2:0] a,
    output reg [15:0] q
);

always @(*) begin
    case (a)
        0: q = 16'b100101100010; // 1232 in hex is 0x1232, which is binary 0

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
