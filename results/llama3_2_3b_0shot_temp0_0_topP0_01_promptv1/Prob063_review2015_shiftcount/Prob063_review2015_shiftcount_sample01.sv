
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
assign q[3] = data;
assign q[2] = q[3];
assign q[1] = q[2];
assign q[0] = q[1];

always @(posedge clk) begin
    if (shift_ena)
        q[3] <= data;
    else if (count_ena && ~q[3])
        q[3] <= 4'b0000;
end

always @(posedge clk) begin
    if (shift_ena)
        q[2] <= q[3];
    else if (count_ena && ~q[2])
        q[2] <= 4'b0000;
end

always @(posedge clk) begin
    if (shift_ena)
        q[1] <= q[2];
    else if (count_ena && ~q[1])
        q[1] <= 4'b0000;
end

always @(posedge clk) begin
    if (shift_ena)
        q[0] <= q[1];
    else if (count_ena && ~q[0])
        q[0] <= 4'b0000;
end

// VERILOG-EVAL: endmodule not found
