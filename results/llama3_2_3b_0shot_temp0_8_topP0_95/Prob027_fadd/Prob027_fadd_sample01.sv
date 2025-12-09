
module TopModule(
    // Input signals
    input [2:0] a,  // bits to be added
    input [1:0] b,  // other bit to be added
    input cin,     // carry-in from previous adder
    // Output signals
    output cout,   // carry-out of the full adder
    output sum     // sum of the three inputs
);

// Assign outputs based on input values
assign cout = a[2]*cin + b[0]*cin;
assign cout = cout | (a[1]*b[1] + a[0]*b[0]);
assign sum  = {a[2], a[1], a[0]};
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
