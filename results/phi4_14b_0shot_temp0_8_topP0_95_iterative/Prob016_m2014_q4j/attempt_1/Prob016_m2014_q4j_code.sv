
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
module FullAdder (
    input a,
    input b,
    input cin,   // Carry in from previous less significant bit
    output sum,
    output cout  // Carry out to more significant bit
);
    assign {cout, sum} = a + b + cin;
endmodule

module TopModule (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire c1, c2, c3; // Intermediate carry signals

    // Instantiate four full adders for each bit of addition
    FullAdder fa0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),  // No carry in for the least significant bit
        .sum(sum[0]),
        .cout(c1)
    );

    FullAdder fa1 (
        .a(x[1]),
        .b(y[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    FullAdder fa2 (
        .a(x[2]),
        .b(y[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    FullAdder fa3 (
        .a(x[3]),
        .b(y[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(sum[4])  // Carry out is the overflow bit
    );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
