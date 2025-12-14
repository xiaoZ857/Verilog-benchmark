
module TopModule (
    input clk,
    input a,
    output reg q
);

    wire d; // Inverted data for the D flip-flop

    // XOR gate to invert 'a' when it's 1
    assign d = a ^ q;

    always @(posedge clk) begin
        q <= d;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
