
module TopModule (
  input in,
  output out
);

always @(in) begin
    out = ~in;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
