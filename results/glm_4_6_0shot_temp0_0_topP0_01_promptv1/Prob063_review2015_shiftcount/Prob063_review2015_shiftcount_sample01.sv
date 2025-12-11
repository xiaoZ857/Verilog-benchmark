
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);

always @(posedge clk) begin
    if (shift_ena) begin
        // Shift right, data comes in as MSB
        q <= {data, q[3:1]};
    end
    else if (count_ena) begin
        // Decrement
        q <= q - 1;
    end
    // If neither is enabled, keep the current value
end
endmodule
