
assign out_sop = (~a & ~b & c & ~d) |
                 (~a & b & c & d) |
                 (a & b & c & d);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
