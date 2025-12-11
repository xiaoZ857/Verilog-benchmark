
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
always @(*) begin
    if (sel == 4'b0000)
        out = a;
    else if (sel == 4'b0001)
        out = b;
    else if (sel == 4'b0010)
        out = c;
    else if (sel == 4'b0011)
        out = d;
    else if (sel == 4'b0100)
        out = e;
    else if (sel == 4'b0101)
        out = f;
    else if (sel == 4'b0110)
        out = g;
    else if (sel == 4'b0111)
        out = h;
    else if (sel == 4'b1000)
        out = i;
    else
        out = 16'hFFFF; // Output '1' for all bits when sel is 9 to 15
end

endmodule
