
assign q = (!a & (b | c | d)) | (a & ((b & c) | (b & d) | (c & d)));

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
