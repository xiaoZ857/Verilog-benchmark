
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
// Define the logic for a single full adder
always_comb begin : FULL_ADDER
  integer carry_in = 0;
  int[1:0] sum_out = {x[2], y[2]};
  
  if (x[3] == '1' || y[3] == '1') begin
    carry_in = 1;
  end
  
  assign sum_out[1] = x[1] + y[1] + carry_in;
  if (sum_out[1] >= 2) 
    sum_out[1] = 1, sum_out[0] = 1; // carry over to sum and overflow
  else if (carry_in == 1) 
    sum_out[0] = 1; // carry only goes into sum
  else 
    sum_out[0] = 0;

end

// Define the logic for handling the most significant bit
assign sum[3] = x[2] + y[2];

// Handle carry out (overflow) for full adder
assign sum[1] = sum_out[1];

// Assign the final sum to output
assign sum[0] = 0; // always set to zero, as per problem statement

endmodule
