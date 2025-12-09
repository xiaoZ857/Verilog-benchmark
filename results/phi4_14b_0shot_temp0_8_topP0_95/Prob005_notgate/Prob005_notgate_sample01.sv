
module TopModule (
  input wire in,        // Declare the input signal
  output reg out        // Declare the output signal as 'reg' since we will assign it within an always block
);

// Use an always_comb block to continuously evaluate the logic
always @(*) begin
  out = ~in;            // Assign the negation of `in` to `out`
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
