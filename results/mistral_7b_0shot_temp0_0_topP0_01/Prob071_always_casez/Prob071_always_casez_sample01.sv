
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);

always @(posedge clk) begin
  if (in[0])
    pos <= 3'b010; // bit[0] is the priority
  else if (in[1])
    pos <= 3'b011; // bit[1] is the priority
  else if (in[2])
    pos <= 3'b100; // bit[2] is the priority
  else if (in[3])
    pos <= 3'b101; // bit[3] is the priority
  else if (in[4])
    pos <= 3'b110; // bit[4] is the priority
  else if (in[5])
    pos <= 3'b111; // bit[5] is the priority
  else if (in[6])
    pos <= 3'b001; // bit[6] is the priority
  else if (in[7])
    pos <= 3'b000; // bit[7] is the priority
  else
    pos <= 3'b000; // no bits are high, output zero
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
