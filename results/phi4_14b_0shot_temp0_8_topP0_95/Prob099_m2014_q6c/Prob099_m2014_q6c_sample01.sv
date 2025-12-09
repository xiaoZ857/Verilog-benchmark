
module TopModule (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

always @(*) begin
    // Logic for Y2
    Y2 = (y[6] & w) | (y[5] & ~w) | (y[4] & w);
    
    // Logic for Y4
    Y4 = (y[3] & w) | (y[2] & ~w);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
