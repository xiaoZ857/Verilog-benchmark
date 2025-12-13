
module TopModule (
  input [99:0] in,
  output reg [98:0] out_both,
  output reg [99:1] out_any,
  output reg [99:0] out_different
);

  integer i;

  always @(*) begin
    // Calculate out_both
    for (i = 0; i < 99; i = i + 1) begin
      out_both[i] = in[i] & in[i+1];
    end

    // Calculate out_any
    for (i = 1; i <= 99; i = i + 1) begin
      out_any[i] = in[i-1] | in[i];
    end

    // Calculate out_different with wrap-around
    for (i = 0; i < 100; i = i + 1) begin
      if (i == 99) begin
        out_different[i] = in[i] ^ in[0]; // Wrap around: left neighbor of in[99] is in[0]
      end else begin
        out_different[i] = in[i] ^ in[i+1];
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
