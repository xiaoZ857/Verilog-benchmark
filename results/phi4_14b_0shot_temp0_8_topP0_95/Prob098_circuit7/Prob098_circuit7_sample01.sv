
module TopModule (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    if (a == 1'b0) begin
        q <= 1'b1;
    end else if (a == 1'b1) begin
        q <= ~q; // Toggle q when a is 1
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
