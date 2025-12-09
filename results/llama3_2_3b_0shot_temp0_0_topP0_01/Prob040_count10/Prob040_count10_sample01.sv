

module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);

always @(*) begin
  q = {4'b0000};
end

always #10 clk_pos edge
begin
  if (reset) begin
    q <= 4'b0000;
  end else begin
    case(q)
      4'b0000: q <= 4'b0001;
      4'b0001: q <= 4'b0010;
      4'b0010: q <= 4'b0100;
      4'b0100: q <= 4'b1000;
      4'b1000: q <= 4'b0000;
    endcase
  end
end

assign q;

// VERILOG-EVAL: endmodule not found
