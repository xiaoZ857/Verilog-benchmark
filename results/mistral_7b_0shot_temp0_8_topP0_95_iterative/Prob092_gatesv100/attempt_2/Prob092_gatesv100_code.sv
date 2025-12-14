
module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
// For out_both
always @(posedge clk) begin
    for (int i = 0; i < 100; i++) begin
        if (i < 98)
            out_both[i] = in[i] & in[i+1];
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
    for (int i = 1; i < 100; i++) begin
        out_different[i] = in[i] ^ in[i-1]; // Use XOR gate to check if bits are different
    end
    out_different[0] = 1'bx; // in[0] has no neighbour to the left, it will always be 'x'
end

// VERILOG-EVAL: endmodule not found
