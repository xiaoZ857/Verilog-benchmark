
module TopModule (
    input [4:1] x,
    output logic f
);

always_comb begin
    // Initialize f to 0
    f = 1'b0;

    // Check each minterm where f is 1
    if ((~x[4] & ~x[3] & ~x[2] & ~x[1]) |   // Minterm 0000
        (~x[4] & ~x[3] & ~x[2] & x[1]) |     // Minterm 0001
        (~x[4] & x[3] & x[2] & ~x[1]) |      // Minterm 1010
        (~x[4] & x[3] & x[2] & x[1]) |       // Minterm 1011
        (x[4] & ~x[3] & ~x[2] & ~x[1]) |     // Minterm 1100
        (x[4] & ~x[3] & ~x[2] & x[1]) |      // Minterm 1101
        (x[4] & x[3] & ~x[2] & ~x[1]))       // Minterm 1110
    begin
        f = 1'b1;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
