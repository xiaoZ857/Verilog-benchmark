
module TopModule (
  output reg one
);

always_comb begin
  one = 1'b1;
end

initial begin
  $finish;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
