
module TopModule (
  input [2:0] in,
  output [1:0] out
);
// Count the '1's in the input vector

reg [1:0] bits = 2;
reg [3:0] total_count = 4;

assign {
    bits[0] = in[0]; // count the least significant bit (rightmost)
    bits[1] = in[1]; // count the middle bit
    bits[2] = in[2]; // count the most significant bit (leftmost)

    total_count <= {total_count, ~bits}; // increment the count if a '0' is encountered, otherwise keep the same value

    out <= total_count & 3; // output the population count
}

// Create an instance of the population count module
TopModule top_module (
  .in(in),
  .out(out)
);
endmodule
