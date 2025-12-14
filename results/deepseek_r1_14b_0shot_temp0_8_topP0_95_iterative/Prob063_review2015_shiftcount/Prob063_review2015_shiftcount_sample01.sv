
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
    if (shift_ena) begin
        reg [3:0] shifted_val;
        shifted_val = {data, q[0], q[1], q[2]};
        q <= shifted_val;
    end else if (count_ena) begin
        q <= q - 1;
    end
end

// VERILOG-EVAL: endmodule not found
