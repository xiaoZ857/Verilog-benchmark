
module TopModule (
  input in1,
  input in2,
  output logic out
);

// AND gate with a bubble on input in2
always @(posedge clk) begin
  if (!in2)
    out <= in1;
  else
    out <= in1 & in2;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
