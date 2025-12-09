

module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);

reg [3:0] q;

always @(posedge clk) begin
  if (shift_ena == 1) begin
    q <= {data, q[2:0]};
  end else if (count_ena == 1 && q != 0) begin
    q <= q[1:0];
  end else begin
    q <= 4'b0000;
  end
end

assign q = q;

endmodule

// VERILOG-EVAL: abnormal backticks count
