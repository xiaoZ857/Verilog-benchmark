

module TopModule (
  input x,
  input y,
  output z
);

wire a1_out, b1_out;
wire a2_out, b2_out;
wire or_out, and_out;

A uut_a1 (.x(x), .y(y), .z(a1_out));
B uut_b1 (.x(x), .y(y), .z(b1_out));

A uut_a2 (.x(x), .y(y), .z(a2_out));
B uut_b2 (.x(x), .y(y), .z(b2_out));

assign or_out = a1_out | b1_out;
assign and_out = a2_out & b2_out;

assign z = or_out ^ and_out;

endmodule

// Module A: Implements the boolean function z = (x^y) & x
module A (
  input x,
  input y,
  output z
);
  assign z = (x ^ y) & x;
endmodule

// Module B: Based on the given simulation waveform
module B (
  input x,
  input y,
  output reg z
);
  always @(*) begin
    case ({x, y})
      2'b00: z = 1'b1;
      2'b01: z = 1'b0;
      2'b10: z = 1'b0;
      2'b11: z = 1'b1;
    endcase
  end
endmodule
