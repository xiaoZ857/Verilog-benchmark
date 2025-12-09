
// Define the TopModule that contains three XOR gates
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

  // Assign statement: direct XOR operation for simplicity
  assign out_assign = a ^ b;

  // Combinational always block: uses logic to implement XOR
  always_comb begin : XOR_comb
    out_always_comb = a ^ b;
  end

  // Clocked always block with flip-flop (RHS latch): produces delayed output
  always_ff @(*) begin : XOR_ff
    reg [1:0] out_always_ff;
    out_always_ff <= {a, b};
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
