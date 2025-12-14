
// Define the AND gate using an assign statement
module TopModule(
    // Input signals
    input a,
    input b,
    
    // Output signals
    output out_assign,  // This is a reg, which should be used for non-clock signals
    output reg out_alwaysblock // This is also a reg and should be used for clock-triggered signals
    
);

// Assign statement implementation
assign out_assign = a & b;

// Combinational always block implementation
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
