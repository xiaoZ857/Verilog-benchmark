
module TopModule (
    input [1:0] A,
    input [1:0] B,
    output reg z
);

always @(*) begin
    // Compare A and B
    if (A == B) begin
        z = 1'b1;   // Set z to 1 if A equals B
    end else begin
        z = 1'b0;   // Set z to 0 otherwise
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
