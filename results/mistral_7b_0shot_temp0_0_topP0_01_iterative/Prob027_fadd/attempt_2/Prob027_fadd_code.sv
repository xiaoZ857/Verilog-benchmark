
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
module FullAdder (
  input a,
  input b,
  input cin,
  output reg cout,
  output reg sum
);

// Internal signals for XOR and AND operations
wire xor_result;
wire and_result;

// XOR gate
xor gates (
  .a(a),
  .b(b),
  .o(xor_result)
);

// AND gate
and gates (
  .a(cin),
  .b(xor_result),
  .o(and_result)
);

// OR gate for sum
or gates (
  .a(a ^ b), // XOR of a and b instead of direct connection
  .b(cin),
  .c(xor_result), // Direct connection of cin and xor_result is fine
  .o(sum)
);

// XOR gate for carry-out calculation
xor gates (
  .a(cin),
  .b(and_result),
  .o(cout)
);

endmodule
