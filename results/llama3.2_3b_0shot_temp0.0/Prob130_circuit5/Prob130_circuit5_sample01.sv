

module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

reg [3:0] q;

always @(*) begin
  case (a)
    4'b000: q = 0;
    4'b001: q = 1;
    4'b010: q = 2;
    4'b011: q = 3;
    4'b100: q = 4;
    4'b101: q = 5;
    4'b110: q = 6;
    4'b111: q = 7;
    default: q = a;
  endcase
end

assign q = q; // Always assign q to itself, as it's not explicitly assigned in the always block
endmodule

// VERILOG-EVAL: abnormal backticks count
