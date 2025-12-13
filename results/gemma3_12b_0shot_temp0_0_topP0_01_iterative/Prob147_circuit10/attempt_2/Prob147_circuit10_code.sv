
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
  always @(posedge clk) begin
    if (clk == 1) begin
      if (a == 1 && b == 1) begin
        q <= 0;
        state <= 0;
      end else if (a == 0 && b == 0) begin
        q <= 0;
        state <= 0;
      end else if (a == 0 && b == 1) begin
        q <= 1;
        state <= 0;
      end else if (a == 1 && b == 0) begin
        q <= 1;
        state <= 1;
      end else if (a == 1 && b == 1) begin
        q <= 0;
        state <= 0;
      end else if (a == 0 && b == 0) begin
        q <= 0;
        state <= 0;
      end else if (a == 1 && b == 0) begin
        q <= 1;
        state <= 1;
      end else if (a == 0 && b == 1) begin
        q <= 1;
        state <= 0;
      end else begin
        q <= q;
        state <= state;
      end
    end else begin
      q <= q;
      state <= state;
    end
  end
endmodule
