
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a == 1) begin
      if (q == 4) begin
        q <= 4;
      end else if (q == 5) begin
        q <= 5;
      end else if (q == 6) begin
        q <= 6;
      end else if (q == 0) begin
        q <= 0;
      end else if (q == 1) begin
        q <= 1;
      end else if (q == 2) begin
        q <= 2;
      end else if (q == 3) begin
        q <= 3;
      end
    end else begin
      if (q == 4) begin
        q <= 4;
      end else if (q == 5) begin
        q <= 5;
      end else if (q == 6) begin
        q <= 6;
      end else if (q == 0) begin
        q <= 0;
      end else if (q == 1) begin
        q <= 1;
      end else if (q == 2) begin
        q <= 2;
      end else if (q == 3) begin
        q <= 3;
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
