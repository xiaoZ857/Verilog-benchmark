
module TopModule (
  input [4:1] x,
  output logic f
);

// Create a look-up table (LUT) to map the inputs to outputs
logic [4:0] lut_lookup[8] = {
  2'b00,    0,
  2'b01,    1,
  2'b11,    2,
  2'b10,    3
};

// Select one of the two options for d based on the input
logic d_choice;

assign d_choice = (x[4] == 1) ? 0 : lut_lookup[x[3]];

// Create the output signal f based on the LUT and d choice
assign f = (x[2][0] & x[2][1]) | ((lut_lookup[x[1]] == 0) & d_choice);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
