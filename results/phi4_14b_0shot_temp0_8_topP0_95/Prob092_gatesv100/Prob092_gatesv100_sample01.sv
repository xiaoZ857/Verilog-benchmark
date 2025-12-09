
module TopModule (
  input [99:0] in,
  output reg [98:0] out_both,
  output reg [99:1] out_any,
  output reg [99:0] out_different
);

integer i;

always @(*) begin
    // Calculate out_both for indices 1 to 98
    for (i = 1; i < 99; i = i + 1) begin
        out_both[i - 1] = in[i] & in[i + 1];
    end

    // Calculate out_any for indices 1 to 99
    for (i = 1; i <= 99; i = i + 1) begin
        out_any[i] = in[i] | in[i - 1];
    end

    // Calculate out_different with wrapping around
    for (i = 0; i < 100; i = i + 1) begin
        if (i == 99)
            out_different[i] = in[i] ^ in[0];  // Wrap-around case
        else
            out_different[i] = in[i] ^ in[i + 1];
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
