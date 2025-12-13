
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
// Define the half adder module
module HalfAdder(
    // Input signals
    input a, 
    input b, 

    // Output signals
    output sum, 
    output cout
);

    // Always block to generate the sum and carry-out
    always @(*)
        begin

            // Calculate the sum using XOR operation
            sum = (a ^ b);
            
            // Calculate the carry-out using AND operation
            cout = ((a & b) == 1'b0); 

        end 

endmodule 
