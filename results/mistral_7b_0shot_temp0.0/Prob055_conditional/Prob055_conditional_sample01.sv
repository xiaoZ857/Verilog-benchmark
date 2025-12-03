

module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);

always @(posedge clk) begin
    if (a < b) begin
        min <= a;
    end else if (b < c) begin
        min <= b;
    end else if (c < d) begin
        min <= c;
    end else begin
        min <= d;
    end
end

// VERILOG-EVAL: endmodule not found
