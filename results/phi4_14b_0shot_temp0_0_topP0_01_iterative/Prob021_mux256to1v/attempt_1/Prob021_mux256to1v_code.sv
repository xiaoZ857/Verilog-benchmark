
module TopModule (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    // Calculate the starting index of the selected 4-bit group
    integer start_index = sel * 4;
    
    // Select the appropriate 4 bits from the input vector
    out = in[start_index +: 4];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
