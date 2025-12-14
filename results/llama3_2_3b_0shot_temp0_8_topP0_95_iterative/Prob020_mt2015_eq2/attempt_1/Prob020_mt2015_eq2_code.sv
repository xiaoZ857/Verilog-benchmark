
module TopModule (
  input [1:0] A,  // 2-bit input A[1:0]
  input [1:0] B,  // 2-bit input B[1:0]
  output z       // output signal z
);

wire z;

assign z = (A == B) ? 1 : 0;  // z is 1 if A equals B, otherwise 0

endmodule

// VERILOG-EVAL: errant inclusion of module definition
