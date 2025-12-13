
always_comb begin
  out = (~a & ~b) | (a & b) | (c & d);
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
