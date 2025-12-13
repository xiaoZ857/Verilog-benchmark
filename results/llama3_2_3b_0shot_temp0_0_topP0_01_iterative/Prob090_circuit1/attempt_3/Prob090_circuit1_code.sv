
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

endmodule

// VERILOG-EVAL: errant inclusion of module definition
