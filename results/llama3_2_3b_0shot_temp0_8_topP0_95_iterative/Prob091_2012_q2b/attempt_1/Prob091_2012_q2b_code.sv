
module TopModule (
  input [5:0] y,
  input w,
  output reg Y1, // reg is necessary for assignment
  output reg Y3
);
  
// The state encoding is a one-hot code as per the problem description.
// For state A (000001), B (000010) and C(000100),
// F has high values and others have low.
// Similarly D (001000) will get high for E(010000) 
// when w is high else goes low.

Y1 = y[1]; // Input of state flip-flop y[1] for the signal Y1
Y3 = (~w & y[4]) | (w & ~y[5]); // Input of state flip-flop y[3]

endmodule

// VERILOG-EVAL: errant inclusion of module definition
