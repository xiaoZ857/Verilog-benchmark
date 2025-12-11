
module TopModule (
  input x3,
  input x2,
  input x1,
  output f
);
always @* begin
    if(x3 == 0)
        if(x2 == 0)
            if(x1 == 0)
                f = 0;
            else
                f = 1;
        else if(x2 == 1)
            if(x1 == 0)
                f = 1;
            else
                f = 1;
    else // x3 is 1
        if(x2 == 0)
            f = 0;
        else if(x2 == 1)
            if(x1 == 0)
                f = 0;
            else
                f = 1;
end
endmodule
