
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

// Assign outputs to the appropriate multiplexers
assign mux_in[0] = sel_0[0];
assign mux_in[1] = sel_1[0];
assign mux_in[2] = sel_2[0];
assign mux_in[3] = sel_3[0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
