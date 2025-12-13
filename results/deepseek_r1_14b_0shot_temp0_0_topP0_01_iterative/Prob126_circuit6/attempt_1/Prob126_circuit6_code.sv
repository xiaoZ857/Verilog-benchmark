
module TopModule (
    input [2:0] a,
    output reg [15:0] q
);

always @(*) begin
    case (a)
        0: q = 1232; // hex '1232'
        1: q = aee0; // hex 'aee0'
        2: q = 27d4; // hex '27d4'
        3: q = 5a0e; // hex '5a0e'
        4: q = 2066; // hex '2066'
        5: q = 64ce; // hex '64ce'
        6: q = c526; // hex 'c526'
        7: q = 2f19; // hex '2f19'
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
