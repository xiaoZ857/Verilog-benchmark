
module TopModule (
  input [4:1] x,
  output logic f
);
assign f = (x[3] & x[2] & !x[1]) | (!x[3] & !x[2]);

// Karnaugh map don't-care conditions are already satisfied with the provided implementation

endmodule
