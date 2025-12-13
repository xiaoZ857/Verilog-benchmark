
module TopModule(
    output one
);

    // Always block to ensure the output is driven high
    always @(*) begin
        one = 1;
    end
endmodule

// VERILOG-EVAL: errant inclusion of module definition
