
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);
// Define the 4-to-1 multiplexer with a and b as selector inputs
logic [3:0] mux_out;
assign mux_out = {c, d, ~c, ~d}[2*a + b];

// Define the 2-to-1 multiplexer with sel as selector inputs
logic [1:0] sel_mux = {c, ~d}; // Using c and ~d from the K-map

// Assign outputs to the appropriate multiplexers based on K-map
assign mux_in[0] = (sel_mux == 00) ? 0 : (sel_mux == 01) ? 1 : (sel_mux == 11) ? 1 : (sel_mux == 10) ? 1 : 0;
assign mux_in[1] = (sel_mux == 01) ? 0 : (sel_mux == 11) ? 0 : (sel_mux == 10) ? 1 : 1;
assign mux_in[2] = (sel_mux == 11) ? 0 : (sel_mux == 10) ? 0 : (sel_mux == 00) ? 1 : 1;
assign mux_in[3] = (sel_mux == 10) ? 0 : (sel_mux == 00) ? 0 : (sel_mux == 01) ? 1 : 1;

// VERILOG-EVAL: endmodule not found
