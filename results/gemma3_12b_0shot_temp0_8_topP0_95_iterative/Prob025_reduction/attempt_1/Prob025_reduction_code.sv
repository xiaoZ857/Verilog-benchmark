
module TopModule (
  input [7:0] in,
  output parity
);

  // Internal signal to store the XOR result
  wire xor_result;

  // XOR the 8 data bits to calculate the parity bit
  xor(in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7], parity);

endmodule

// Define a custom XOR function for 8 inputs
module xor (
  input a,
  input b,
  input c,
  input d,
  input e,
  input f,
  input g,
  input h,
  output reg out
);

  always @* begin
    out = a ^ b ^ c ^ d ^ e ^ f ^ g ^ h;
  end
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
