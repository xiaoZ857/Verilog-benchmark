
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);

  always @(*) begin
    out = count_ones(in);
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
