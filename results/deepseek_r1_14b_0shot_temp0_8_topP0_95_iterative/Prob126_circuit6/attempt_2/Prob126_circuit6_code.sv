
module TopModule (
  input [2:0] a,
  output reg [15:0] q
);
always @(*) begin
    case (a)
        0: q = 16'b100101100010; // 1232 in hex is 0x1232, which is binary 0
        1: q = 16'haee0;
        2: q = 16'h27d4;
        3: q = 16'h5a0e;
        4: q = 16'h2066;
        5: q = 16'h64ce;
        6: q = 16'hc526;
        7: q = 16'h2f19;
    endcase
end

// VERILOG-EVAL: endmodule not found
