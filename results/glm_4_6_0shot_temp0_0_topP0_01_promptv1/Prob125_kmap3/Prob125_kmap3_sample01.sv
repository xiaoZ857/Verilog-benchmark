
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

always @(*) begin
    if (a) begin
        if (c & d) begin
            out = 1'b1;
        end else if (c & ~d) begin
            out = 1'b1;
        end else if (~c & d) begin
            out = 1'b0;
        end else begin
            out = 1'b1;
        end
    end else begin
        out = 1'b0;
    end
end
endmodule
