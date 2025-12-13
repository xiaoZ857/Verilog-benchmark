
// Prob027_fadd_ref.sv - Full Adder Reference Implementation

module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Calculate sum and carry-out
  wire s1, s2;
  
  // Sum without carry-out
  assign s1 = a ^ b;
  
  // Carry-out from the first addition (a + b)
  assign s2 = a & b;
  
  // Total carry-out including the carry-in
  assign cout = s2 | (s1 & cin);
  
  // Final sum with carry-in
  assign sum = s1 ^ cin;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
