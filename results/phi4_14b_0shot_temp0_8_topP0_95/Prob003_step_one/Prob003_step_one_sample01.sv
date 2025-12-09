
module TopModule (
  output reg one
);

// Initialize the output to always drive '1'
always @(*) begin
  one = 1'b1;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
