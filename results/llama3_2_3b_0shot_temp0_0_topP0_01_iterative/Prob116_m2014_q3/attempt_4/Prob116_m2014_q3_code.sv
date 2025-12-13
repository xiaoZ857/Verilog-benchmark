
module TopModule (
  input [4:1] x,
  output logic f
);
always_comb begin
    logic f;
    
    if(x[2] == 00) begin
        f = d;
    end else if(x[2] == 01) begin
        f = (x[3] & d) | (~d & x[4]);
    end else if(x[2] == 11) begin
        f = ((~d) & x[3]) | (x[4] & d);
    end else if(x[2] == 10) begin
        f = (x[3] & ~d) | (x[4] & d);
    end
end

endmodule
