
module TopModule (
    input [3:0] in,
    output reg [1:0] pos
);

always @(posedge clk) begin
    if (in[3])
        pos <= 4'b0101; // when MSB is set, the priority is 4
    else if (in[2])
        pos <= 4'b0110; // when MSB and second MSB are not set, but the second MSB is set, the priority is 3
    else if (in[1])
        pos <= 4'b0111; // when MSB, second MSB, and third MSB are not set, but the third MSB is set, the priority is 2
    else if (in[0])
        pos <= 4'b1000; // when all MSB bits are not set, but LSB is set, the priority is 1
    else
        pos <= 4'b0000; // if none of the input bits are high, output zero
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
