
module TopModule(
    input a, // Positive clock/clk triggered
    input b, // Positive clock/clk triggered
    output q   // Q is not clocked
);

    always @(*) begin
        if (a == 1 && b == 0) begin
            q = 0;
        end else if (a == 1 && b == 1) begin
            q = 1;
        end else if (a == 0 && b == 1) begin
            q = 0;
        end else begin // a == 0 and b == 0
            q = 0;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
