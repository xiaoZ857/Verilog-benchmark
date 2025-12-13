
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
  // Shift register to hold the last four input bits
  reg [3:0] shift_reg;

  // Register to hold the start_shifting flag
  reg start_shifting_reg;

  // Output assignment
  assign start_shifting = start_shifting_reg;

  // Sequential logic: synchronous reset and state update
  always @(posedge clk) begin
    if (reset) begin
      shift_reg        <= 4'b0000;
      start_shifting_reg <= 1'b0;
    end else begin
      // Shift in the new data bit
      shift_reg <= {shift_reg[2:0], data};

      // Once the sequence 1101 is detected, keep start_shifting high
      start_shifting_reg <= start_shifting_reg | (shift_reg == 4'b1101);
    end
  end

endmodule
