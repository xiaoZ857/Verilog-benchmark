
module TopModule (
  input wire clk,
  input wire in,
  output logic out
);

  // Intermediate register to hold the stable value of 'out'
  logic q;
  
  // Calculate the XOR using the stable value from the previous cycle
  always_comb begin
    q = in ^ out;
  end

  // D flip-flop process with positive edge-triggered clock
  always_ff @(posedge clk) begin
    // Assign the result of the XOR to 'out' at every rising edge of 'clk'
    out <= q;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
