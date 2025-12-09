
module TopModule (
    input x,
    input y,
    output z
);
    assign z = ~(x ^ y); // z is 1 when x equals y

endmodule

// VERILOG-EVAL: errant inclusion of module definition
