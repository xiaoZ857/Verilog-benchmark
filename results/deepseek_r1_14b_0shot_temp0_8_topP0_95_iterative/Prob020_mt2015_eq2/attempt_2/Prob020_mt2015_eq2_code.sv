
`timescale 1ns / 1ps

module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);

reg z;
always_comb begin
  for (int i=0; i<2; i++) begin
    if (A[i] != B[i]) begin
      z = 0;
      break;
    end
  end
  else begin
    z = 1;
  end
end

// Alternatively, you can use a more concise approach:
// assign z = (A[0] == B[0] && A[1] == B[1]);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
