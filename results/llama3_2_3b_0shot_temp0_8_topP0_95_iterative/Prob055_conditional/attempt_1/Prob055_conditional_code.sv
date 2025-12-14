
module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);

reg [7:0] min;
always_comb begin
  if (a < b) begin
    if (c < d) begin
      if (a < c) begin
        if (b < d) begin
          min = a;
        end else begin
          min = b;
        end
      end else begin
        min = c;
      end
    end else begin
      if (d < b) begin
        min = d;
      end else begin
        min = b;
      end
    end
  end else if (b < c) begin
    if (a < d) begin
      min = a;
    end else begin
      min = d;
    end
  end else if (c < d) begin
    min = c;
  end else begin
    min = d;
  end
end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
