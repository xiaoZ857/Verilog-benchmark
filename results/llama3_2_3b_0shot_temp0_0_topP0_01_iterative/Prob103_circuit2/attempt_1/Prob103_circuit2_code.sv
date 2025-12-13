
module TopModule (
    input a, // Clock signal
    input b, 
    input c, 
    input d, 
    output q // Output signal
);

// Combinational logic to generate the output signal 'q'
assign q = (a && !b) || (!c && !d);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
