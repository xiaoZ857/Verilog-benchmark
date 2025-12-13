
// TopModule.v
// 3‑input OR – implements the Karnaugh‑map function
module TopModule (
    input  wire a,
    input  wire b,
    input  wire c,
    output wire out
);
    // Combinational logic – no clock needed
    assign out = a | b | c;   // a + b + c
endmodule

// VERILOG-EVAL: errant inclusion of module definition
