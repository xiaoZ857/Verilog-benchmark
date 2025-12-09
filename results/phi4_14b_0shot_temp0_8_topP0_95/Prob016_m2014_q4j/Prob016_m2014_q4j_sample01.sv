
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
module FullAdder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module FourBitAdder (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire c1, c2, c3; // Carry wires between full adders

    // Instantiate the first full adder
    FullAdder fa0(
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),  // No carry-in for the least significant bit
        .sum(sum[0]),
        .cout(c1)
    );

    // Instantiate the second full adder
    FullAdder fa1(
        .a(x[1]),
        .b(y[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    // Instantiate the third full adder
    FullAdder fa2(
        .a(x[2]),
        .b(y[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    // Instantiate the fourth full adder
    FullAdder fa3(
        .a(x[3]),
        .b(y[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(sum[4])  // The carry-out of the last full adder is the overflow bit
    );

endmodule

// Top module that utilizes the FourBitAdder
module TopModule (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    
    // Instantiate the 4-bit adder
    FourBitAdder adder(
        .x(x),
        .y(y),
        .sum(sum)
    );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
