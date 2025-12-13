
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
    if (shift_ena) begin
        // Shift in the new data from MSB
        q <= {data, q[3:1]};
    end else if (count_ena && q != 4'b0000) begin
        // Decrement the current value only if it's not zero
        q <= q - 1;
    end
end

// VERILOG-EVAL: endmodule not found
