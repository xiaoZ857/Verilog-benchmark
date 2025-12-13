
module TopModule (
  input [4:1] x,
  output logic f
);
always_comb begin
    case(x[2])
        00: f = d;
        01: f = (x[3] & d) | (~d & x[4]);
        11: f = ((~d) & x[3]) | (x[4] & d);
        10: f = (x[3] & ~d) | (x[4] & d);
    endcase
end

// VERILOG-EVAL: endmodule not found
