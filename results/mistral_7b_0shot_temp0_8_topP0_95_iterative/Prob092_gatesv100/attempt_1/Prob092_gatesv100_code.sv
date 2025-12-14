
module TopModule (
    input [99:0] in,
    output reg [98:0] out_both,
    output reg [99:1] out_any,
    output reg [99:0] out_different
);

// For out_both
always @(posedge clk) begin
    for (int i = 0; i < 100; i++) begin
        if (i < 99)
            out_both[i] = in[i] & in[i+1];
        else
            out_both[i] = 0; // Since in[99] has no neighbour to the left, it will always be 0
    end
end

// For out_any
always @(posedge clk) begin
    for (int i = 1; i < 100; i++) begin
        if (in[i] || in[i-1])
            out_any[i] = 1;
        else
            out_any[i] = 0;
    end
end

// For out_different
always @(posedge clk) begin
    for (int i = 0; i < 100; i++) begin
        if (i > 0)
            out_different[i] = in[i] ^ in[i-1]; // Use XOR gate to check if bits are different
        else
            out_different[i] = 1'bx; // in[0] has no neighbour to the left, it will always be 'x'
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
