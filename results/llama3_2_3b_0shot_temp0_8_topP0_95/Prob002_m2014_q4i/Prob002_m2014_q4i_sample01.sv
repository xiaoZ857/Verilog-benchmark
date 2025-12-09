
// Define the TopModule
module TopModule (
    // Output signal 'out'
    output out
);

    // Always block to assign the output directly to 0 (logic low)
    always @(*) begin
        out = 0;
    end
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
