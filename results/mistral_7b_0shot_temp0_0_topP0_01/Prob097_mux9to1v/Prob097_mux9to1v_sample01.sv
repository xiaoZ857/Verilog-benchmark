

module TopModule (
  input [15:0] a,
  input [15:0] b,
  input [15:0] c,
  input [15:0] d,
  input [15:0] e,
  input [15:0] f,
  input [15:0] g,
  input [15:0] h,
  input [15:0] i,
  input [3:0] sel,
  output logic [15:0] out
);

always @(posedge clk) begin
  case (sel)
    4'b0001 : out <= a;
    4'b0010 : out <= b;
    4'b0100 : out <= c;
    4'b0110 : out <= d;
    4'b1000 : out <= e;
    4'b1010 : out <= f;
    4'b1100 : out <= g;
    4'b1110 : out <= h;
    4'b1001 : out <= i;
    default : out <= 16'b1111111111111111; // for unused cases (sel=9 to 15)
  endcase
end

// VERILOG-EVAL: endmodule not found
