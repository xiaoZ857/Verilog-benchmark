
module TopModule (
    output out // Output signal
);

// Immediately assigned logic to ensure the output is driven low
assign out = 0; // Always drive the output to 0

endmodule

// VERILOG-EVAL: errant inclusion of module definition
