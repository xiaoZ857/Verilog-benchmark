
module TopModule (
  input [2:0] a,
  output reg [15:0] q
);
always @(*) begin
    case (a)
        0: q = 0x1232; // hex '1232'
        1: q = 0xaee0; // hex 'aee0'
        2: q = 0x27d4; // hex '27d4'
        3: q = 0x5a0e; // hex '5a0e'
        4: q = 0x2066; // hex '2066'
        5: q = 0x64ce; // hex '64ce'
        6: q = 0xc526; // hex 'c526'
        7: q = 0x2f19; // hex '2f19'
    endcase
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
