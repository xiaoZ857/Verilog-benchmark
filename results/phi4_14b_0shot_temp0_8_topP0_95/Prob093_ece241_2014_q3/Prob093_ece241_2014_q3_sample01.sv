
module TopModule (
    input c,
    input d,
    output [3:0] mux_in
);

    wire c_not, d_not;
    assign c_not = ~c;
    assign d_not = ~d;

    // mux_in[0] for ab = 00: c' d'
    wire [1:0] m0_inputs = {1'b1, 1'b0};
    assign mux_in[0] = (m0_inputs[c]);

    // mux_in[1] for ab = 01: Always 0
    assign mux_in[1] = 1'b0;

    // mux_in[2] for ab = 11: Always 1
    assign mux_in[2] = 1'b1;

    // mux_in[3] for ab = 10: d'
    assign mux_in[3] = d_not;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
