
module TopModule (
  input [7:0] in,
  output [31:0] out
);

reg [7:0] sign_replication;
assign sign_replication = {in[7], in[7], in[7], in[7], in[7], in[7], in[7], in[7], 0, 0, 0, 0, 0, 0, 0, 0};

assign out = sign_replication & in | ~sign_replication << 8;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
