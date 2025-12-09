
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
// Half Adder Module

module half_adder(
  // inputs
  input clk, // Clock signal
  input [1:0] in_a, // First binary input
  input [1:0] in_b, // Second binary input
  output [1:0] out_sum, // Sum of the two inputs
  output cout        // Carry-out bit
);

  // Initialize outputs to zero
  reg [1:0] sum_reg = 0;
  wire cout_wire;

  always @(posedge clk) begin
    // Compute sum and carry using bitwise operations
    if (in_a == in_b) begin
      sum_reg <= 0;         // No carry when inputs are same
      cout_wire <= 0;       // No carry when inputs are same
    else if ((~in_a & in_b) || (~in_b & in_a)) begin
      sum_reg <= {1'b1, 1'b0}; // Carry bit is set for one of the inputs
      cout_wire <= 1;
    end else if ((~in_a & ~in_b)) begin
      sum_reg <= {{1'b0}, {in_a[0], in_b[0]}};
      cout_wire <= 1;
    end else begin // If not, then there's no need for the else statement 
      sum_reg <= {1'b1, 1'b0}; // Carry bit is set
      cout_wire <= 1;
   end

  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
