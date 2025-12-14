
assign out = (a & b) | ((~a & ~b) & c) | (~(a & !b)) | (!a & b);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
