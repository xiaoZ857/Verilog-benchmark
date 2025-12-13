
module TopModule (
    input clk,
    input resetn,
    input in,
    output out
);

    // Declare four D flip-flops for the shift register stages
    dff ff1 (
        .clk(clk),
        .reset(resetn),  // Active-low reset connected directly
        .d(in),
        .q(q1)
    );

    dff ff2 (
        .clk(clk),
        .reset(resetn),
        .d(q1),
        .q(q2)
    );

    dff ff3 (
        .clk(clk),
        .reset(resetn),
        .d(q2),
        .q(q3)
    );

    dff ff4 (
        .clk(clk),
        .reset(resetn),
        .d(q3),
        .q(out)  // Output is the Q of the last flip-flop
    );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
