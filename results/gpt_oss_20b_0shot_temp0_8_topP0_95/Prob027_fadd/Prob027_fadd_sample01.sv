
// ------------------------------------------------------------
//  Full Adder
//  Adds three 1‑bit inputs (a, b, cin) and produces a 1‑bit sum
//  and a 1‑bit carry‑out (cout).
// ------------------------------------------------------------
module TopModule (
    input  wire a,      // first addend
    input  wire b,      // second addend
    input  wire cin,    // carry‑in from previous stage
    output wire cout,   // carry‑out to next stage
    output wire sum     // sum of a, b and cin
);

    // Sum is the XOR of the three inputs
    assign sum = a ^ b ^ cin;

    // Carry‑out is true if at least two of the inputs are 1
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
