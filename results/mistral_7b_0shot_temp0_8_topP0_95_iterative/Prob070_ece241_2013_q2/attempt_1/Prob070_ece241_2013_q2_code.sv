
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

always @(posedge clk) begin
  out_sop <= (d & (c >> 1)) | ((c & 1) * (d + c)) | (4 * d + 4 * c + 4 * (c >> 1));
end

always @(posedge clk) begin
  out_pos <= !(out_sop);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
