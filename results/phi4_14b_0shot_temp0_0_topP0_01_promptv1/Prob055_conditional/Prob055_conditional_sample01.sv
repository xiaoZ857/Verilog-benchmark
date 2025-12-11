
module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);
always @(*) begin
    if (a < b) begin
        if (a < c)
            min = a;
        else
            min = c;
    end else begin
        if (b < c)
            min = b;
        else
            min = c;
    end

    if (min > d)
        min = d;
end
endmodule
