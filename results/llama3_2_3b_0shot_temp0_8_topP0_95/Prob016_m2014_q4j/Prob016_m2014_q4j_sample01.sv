
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
// Define the clock signal as a positive edge (rising) event
`define CLK_RISING(clk)

module FourBitAdder(
  input clk, // Positive clock/clk triggered
  input [3:0] x,  // Input signals for addend A
  input [3:0] y,  // Input signals for addend B
  output [4:0] sum   // Output signal for the sum (including overflow bit)
);

  localparam [1:0] FULL_ADDER_SIZE = 2; // Size of each full adder

  reg [FULL_ADDER_SIZE * 3:0] carry_in; // Carry-in signals for each full adder
  reg [FULL_ADDER_SIZE * 4:0] sum_out;    // Output sums from each full adder
  reg [1:0] carry_out;                     // Carry-out signal from the last full adder

  always @(posedge clk) begin // Clocked logic
    if (`CLK_RISING(clk)) begin // Rising edge of clock

      // Calculate carry-in signals for each full adder
      assign carry_in[2] = `log2(x[3]);
      carry_in[1:0]   = x[2:3];

      assign carry_in[FULL_ADDER_SIZE] = 1;
      if (`CLK_RISING(clk)) begin // Rising edge of clock
        carry_out <= carry_in[FULL_ADDER_SIZE] + carry_in[FULL_ADDER_SIZE-1];
      end

      // Calculate output sums from each full adder
      for (int i = FULL_ADDER_SIZE - 1; i >= 0; i--) begin : FULL_ADDER_LOOP
        sum_out[i*3+2] <= y[FullAdderIndex(i)][2];
        sum_out[i*3+1] <= carry_in[i] + x[FullAdderIndex(i)][1];
        sum_out[i*3]    <= x[FullAdderIndex(i)][0];
      end

      // Calculate final output sum and overflow bit
      assign sum_out[0] = sum_out[0];
      if (`CLK_RISING(clk)) begin // Rising edge of clock
        carry_in[FULL_ADDER_SIZE + 1] <= sum_out[FULL_ADDER_SIZE];
        if (carry_in[FULL_ADDER_SIZE] == 1) begin
          for (int i = FULL_ADDER_SIZE - 2; i >= 0; i--) begin : FULL_ADDER_LOOP
            sum_out[i*3+2] <= y[FullAdderIndex(i)][2];
            sum_out[i*3+1] <= carry_in[i] + x[FullAdderIndex(i)][1];
            sum_out[i*3]    <= x[FullAdderIndex(i)][0];
          end
        end
      end

      // Assign sum and overflow bits to output
      assign sum[4-1:0] = {sum_out[0], sum_out[1], sum_out[2], sum_out[3]};
      assign carry_out[FULL_ADDER_SIZE + 1] <= carry_in[FULL_ADDER_SIZE];

    end // if rising edge of clock
  end // always

function [1:0] FullAdderIndex(int i);
begin
  FullAdderIndex <= i;
endfunction : FullAdderIndex

endmodule // FourBitAdder
