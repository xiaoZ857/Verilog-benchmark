
module TopModule (
  output out
);

always_comb begin
  out <= 0;
end

initial begin
  $finish;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
