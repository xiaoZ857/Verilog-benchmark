
module TopModule(
    input a, 
    input b, 
    input c,
    input [2:0] in_d, // d is don't-care, so we choose 1 to avoid confusion with other bits
    output reg out
);

    always @(*) begin
        // Assign outputs based on Karnaugh map
        if (in_d == 00) 
            out = 0;
        else if (in_d == 01)
            out = 0;
        else if (in_d == 10)
            out = 1;
        else if (in_d == 11)
            out = 1;
    end
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
