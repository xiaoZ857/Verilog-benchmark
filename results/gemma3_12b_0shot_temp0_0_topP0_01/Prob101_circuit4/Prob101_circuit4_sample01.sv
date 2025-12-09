

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  always @(a or b or c or d) begin
    if (a == 1) begin
      if (b == 0) begin
        if (c == 0) begin
          if (d == 0) begin
            q = 0;
          end else if (d == 1) begin
            q = 0;
          end
        end else if (c == 1) begin
          if (d == 0) begin
            q = 1;
          end else if (d == 1) begin
            q = 1;
          end
        end
      end else if (b == 1) begin
        if (c == 0) begin
          if (d == 0) begin
            q = 1;
          end else if (d == 1) begin
            q = 1;
          end
        end else if (c == 1) begin
          if (d == 0) begin
            q = 1;
          end else if (d == 1) begin
            q = 1;
          end
        end
      end
    end else begin
      q = 0;
    end
  end
endmodule
