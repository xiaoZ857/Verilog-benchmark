
// TopModule.v
// 2‑bit equality comparator
// z = 1  if A == B
// z = 0  otherwise
//
// No clock is required – the logic is combinational.

module TopModule (
    input  wire [1:0] A,   // 2‑bit input A
    input  wire [1:0] B,   // 2‑bit input B
    output wire       z    // equality flag
);

    // Simple continuous assignment – synthesizers will map this to a 2‑bit
    // comparator (or a few XOR gates + an AND).
    assign z = (A == B);

    // If you prefer an explicit always block (useful for simulation or
    // when you want to add more logic later), you can write:
    /*
    always @(*) begin
        if (A == B)
            z = 1'b1;
        else
            z = 1'b0;
    end
    */

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
