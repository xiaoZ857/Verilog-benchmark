
module TopModule (
  input x,
  input y,
  output z
);
// A submodule
module A (
  input wire a,
  input wire b,
  output reg out
);
  assign out = (a ^ b) & a;
endmodule

// B submodule
module B (
  input wire clk,
  input wire reset,
  input wire x,
  input wire y,
  output reg z
);
  reg local_x = x;
  reg local_y = y;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      local_x <= 0;
      local_y <= 0;
      z <= 1'b1;
    end else begin
      local_x <= x;
      local_y <= y;
      case ({local_x, local_y})
        2'b00: z <= 1'b1;
        2'b01: z <= 1'b0;
        2'b10: z <= 1'b0;
        2'b11: z <= 1'b1;
      endcase
    end
  end
endmodule

// OR gate
module or_gate (
  input wire a,
  input wire b,
  output reg out
);
  assign out = a | b;
endmodule

// AND gate
module and_gate (
  input wire a,
  input wire b,
  output reg out
);
  assign out = a & b;
endmodule

// XOR gate
module xor_gate (
  input wire a,
  input wire b,
  output reg out
);
  assign out = a ^ b;
endmodule

// Top-level circuit implementation
A A1 (x, y, z1);
B B1 (clk, reset, x, y, z2);
or_gate OR1 (z1, z2, z3);
A A2 (x, y, z4);
B B2 (clk, reset, x, y, z5);
and_gate AND1 (z4, z5, z6);
xor_gate XOR1 (z3, z6, z);

reg clk = 0;
reg [31:0] time;
reg [1:0] reset = 2'b0; // reset is active low

always @(posedge clk) begin
  if (time < 100) begin
    clk <= !clk; // clock toggles every ns
  end else begin
    clk <= 0; // clock stays low after 100ns
  end
end

// A submodule z1 and B submodule z2 are connected to an OR gate, so we need a continuous assignment for z3
assign z3 = z1 | z2;
