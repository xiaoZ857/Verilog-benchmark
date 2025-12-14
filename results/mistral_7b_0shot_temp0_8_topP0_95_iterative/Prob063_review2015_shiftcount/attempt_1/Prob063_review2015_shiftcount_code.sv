
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);

reg [3:0] temp; // Temporary register to store the shifted data
always @(posedge clk) begin
  if (shift_ena) begin
    temp[3] <= data; // Shift in most significant bit when shift_ena is 1
    for (int i = 3; i > 0; i--)
      temp[i] <= temp[i-1];
  end
  else if (count_ena && shift_ena == 0) begin // Decrement the counter only when shift_ena is 0
    temp[0] <= temp[0] - 1;
    if (temp[0] < 0)
      temp[0] = 4'b0001; // Wrap around to 4'b0001 (1 in binary) when count reaches 0
  end

  q <= temp; // Assign the shifted and/or decremented data to output register q
end

// Optional reset functionality:
initial begin
  forever #5 $finish; // Simulation stops after 5 clock cycles by default
  if (clk)
    temp <= 4'b0000; // Reset the shift register to all zeros when clk is high
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
