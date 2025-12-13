
module TopModule (
  input c,
  input d,
  output [3:0] mux_in
);

// Define 2-to-1 multiplexers
logic [1:0] sel_0 = {c, ~d};
logic [1:0] sel_1 = {d, c};
logic [1:0] sel_2 = {~d, c};
logic [1:0] sel_3 = {~d, ~c};

// Assign outputs to the appropriate multiplexers based on K-map
assign mux_in[0] = (cd == 00) ? 0 : (cd == 01) ? 1 : (cd == 11) ? 1 : (cd == 10) ? 1 : 0;
assign mux_in[1] = (cd == 01) ? 0 : (cd == 11) ? 0 : (cd == 10) ? 0 : 1;
assign mux_in[2] = (cd == 11) ? 0 : (cd == 10) ? 0 : (cd == 00) ? 1 : 1;
assign mux_in[3] = (cd == 10) ? 0 : (cd == 00) ? 0 : (cd == 01) ? 1 : 1;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
