
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
// Initial values for DFFs (in this case 0x34)
initial begin
  // Assign the initial value to all DFFs
  q[0:7] = 34'h34;
end

// Create 8 instances of D flip-flop
DFlipFlop dff [
  'a0, 'a1, 'a2, 'a3, 'a4, 'a5, 'a6, 'a7
];

// Connect DFFs to output q
assign q = {
  dff['a0].q,
  dff['a1].q,
  dff['a2'].q,
  dff['a3'].q,
  dff['a4'].q,
  dff['a5'].q,
  dff['a6'].q,
  dff['a7].q
};

// Create DFF instances with active high synchronous reset and negative edge triggered by clk
DFlipFlop Q1 (
  .D(d), // Input data
  .Q(q[$bitpos(q)], $bitpos(q)+1), // Output Q 
  .clock(clk[0]), // Clock input (active high)
  .reset(reset) // Reset pin
);

// Create another DFF instance to connect to output q
DFlipFlop Q2 (
  .Q(q[$bitpos(q)], $bitpos(q)+1), // Output Q 
  .clock(clk[0]), // Clock input (active high)
  .reset(reset) // Reset pin
);

endmodule
