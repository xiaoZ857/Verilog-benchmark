
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
// Internal signals for the full adder
wire temp_sum;
wire temp_cout;

// Full Adder logic
assign temp_sum = a + b + cin;
assign temp_cout = (a + b + cin) > 2'd3 ? 1'b1 : 1'b0;

// Output signals
assign sum[2] = temp_sum;
assign cout = temp_cout;

endmodule
