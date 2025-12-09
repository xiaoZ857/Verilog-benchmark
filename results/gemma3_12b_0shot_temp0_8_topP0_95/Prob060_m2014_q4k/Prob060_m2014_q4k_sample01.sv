
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);

  // Internal signals for the four D flops
  reg [3:0] shift_reg;

  // Assign the output to the last flop in the shift register
  assign out = shift_reg[3];

  // Sequential logic for the shift register
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      // Reset condition: clear all flops
      shift_reg <= 0;
    end else begin
      // Shift the register:
      // The first flop gets the input signal
      shift_reg[0] <= in;
      // The remaining flops shift the value from the previous flop
      shift_reg[1] <= shift_reg[0];
      shift_reg[2] <= shift_reg[1];
      shift_reg[3] <= shift_reg[2];
    end
  end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
