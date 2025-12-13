
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (shift_ena || !count_ena) begin // Shift or count operation can occur when either shift_ena or count_ena is 1
    if (shift_ena) begin // Shift operation
      q[3] <= data;
      for (int i = 3; i > 0; i--)
        q[i] <= q[i-1];
    end else if (count_ena && !full_counter()) begin // Count operation
      q[0] <= q[3] - 1'b1; // Decrement the least significant bit
      for (int i = 3; i > 0; i--)
        if (q[i] == 2'b10) // If borrow occurs, propagate it to the left
          q[i-1] <= 2'b10;
        else if (q[i] == 1'b1)
          q[i-1] <= 1'b0;
        else
          q[i-1] <= q[i];
    end
  end
end

function full_counter : boolean;
  variable temp [3:0];
  always @* begin
    if (count_ena) begin
      temp = q; // Save current state of the shift register
      for (int i = 3; i > 0; i--)
        if (temp[i] == 1'b1) // Check if all bits are set to 1
          full_counter <= 1'b1;
    end
  end
  return full_counter;
endfunction : full_counter

initial begin
  q = 4'b0000; // Initialize the shift register to all zeros
end

// Add timescale directive outside of any module definition
`timescale 1ns / 1ps

// VERILOG-EVAL: endmodule not found
