
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (shift_ena && !count_ena) begin // Shift when shift_ena is 1 and count_ena is 0
    temp[0] <= data; // Shift in most significant bit when shift_ena is 1
    for (int i = 0; i < 4; i++)
      temp[(i+1) % 4] <= temp[i];
  end else if (!shift_ena && count_ena) begin // Decrement the counter when count_ena is 1 and shift_ena is 0
    temp[3] <= temp[3] - 1;
    if (temp[3] < 0)
      temp[3] = 4'b0001; // Wrap around to 4'b0001 (1 in binary) when count reaches 0
  end else if (shift_ena == count_ena) begin // If both shift_ena and count_ena are high, do nothing
    ;
  end

  q <= temp; // Assign the shifted and/or decremented data to output register q
end

// VERILOG-EVAL: endmodule not found
