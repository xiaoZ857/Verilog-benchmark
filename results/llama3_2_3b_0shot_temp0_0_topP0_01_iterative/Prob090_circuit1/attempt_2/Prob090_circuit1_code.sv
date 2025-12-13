
module TopModule (
    input a,
    input b,
    output q
);

    reg [1:0] q; // declare q as a reg

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

    always @(*) begin // add another always block to clock q
        #50 ns q <= q; // assign q on the rising edge of the clock
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
