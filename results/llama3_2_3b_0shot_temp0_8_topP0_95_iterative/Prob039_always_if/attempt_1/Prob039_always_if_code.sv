
module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);
// Module for a 2-to-1 mux with select signals sel_b1 and sel_b2
module mux_2to1(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    // Select the output based on the values of sel_b1 and sel_b2
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    always @(posedge clk)
        out_always = out_assign;
endmodule

// Module for TopModule with 2-to-1 muxes
module TopModule(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

    mux_2to1 mux_1(
        .a(a),
        .b(b),
        .sel_b1(sel_b1),
        .sel_b2(sel_b2),
        .out_assign(out_assign),
        .out_always(out_always)
    );

    mux_2to1 mux_2(
        .a(a),
        .b(b),
        .sel_b1(sel_b1),
        .sel_b2(sel_b2),
        .out_assign(out_assign),
        .out_always(out_always)
    );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
