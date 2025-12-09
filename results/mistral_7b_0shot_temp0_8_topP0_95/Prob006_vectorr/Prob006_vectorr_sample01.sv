
module TopModule (
  input [7:0] in,
  output [7:0] out
);

always @(posedge clk) begin
    assign out = in[(7+0-${integer(width(out))/2}] + {in[(7+1-${integer(width(out))/2}],
                                             in[(7+2-${integer(width(out))/2}],
                                             in[(7+3-${integer(width(out))/2}],
                                             in[(7+4-${integer(width(out))/2}],
                                             in[(7+5-${integer(width(out))/2}],
                                             in[(7+6-${integer(width(out))/2}],
                                             in[(7+7-${integer(width(out))/2}]};
endmodule

// VERILOG-EVAL: errant inclusion of module definition
