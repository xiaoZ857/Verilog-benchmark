
module TopModule (
  input [7:0] in,
  output reg [7:0] out
);

  // On every positive edge of a clock or whenever needed, assign reversed bits.
  always @(*) begin
    // Assign each bit from the input to its reverse position in the output
    out[0] = in[7];
    out[1] = in[6];
    out[2] = in[5];
    out[3] = in[4];
    out[4] = in[3];
    out[5] = in[2];
    out[6] = in[1];
    out[7] = in[0];
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
