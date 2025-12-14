
module TopModule (
    input [254:0] in,
    output reg [7:0] out
);

always @(*) begin
    // Initialize the counter to zero for each evaluation cycle.
    integer i;
    out = 8'b0;

    // Loop through each bit of the input vector and count '1's.
    for (i = 0; i < 255; i = i + 1) begin
        if (in[i] == 1'b1)
            out = out + 1;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
