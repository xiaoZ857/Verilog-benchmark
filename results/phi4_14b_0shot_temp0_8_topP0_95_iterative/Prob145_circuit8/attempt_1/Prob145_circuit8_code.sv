
module TopModule (
    input clock,
    input a,
    output reg p,
    output reg q
);

always @(posedge clock) begin
    if (a == 1'b0) begin
        // If 'a' is 0 on rising edge, reset both outputs.
        p <= 1'b0;
        q <= 1'b0;
    end else begin
        // If 'a' is 1 on rising edge, set both outputs to 1.
        p <= 1'b1;
        q <= 1'b1;
    end
end

always @(negedge clock) begin
    if (p == 1'b1 && q == 1'b1) begin
        // On falling edge, reset 'p' but hold 'q'.
        p <= 1'b0;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
