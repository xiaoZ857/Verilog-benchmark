
module TopModule (
  input a,
  input b,
  output q
);
always @* begin
    if (a == b)
        q = 1'b1;
    else
        q = 1'b0;
end
endmodule
