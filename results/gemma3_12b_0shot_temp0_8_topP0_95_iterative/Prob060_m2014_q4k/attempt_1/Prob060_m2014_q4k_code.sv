
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);

  // Internal signals for the four D flops
  reg [3:0] shift_reg;

  // Assign the output to the MSB of the shift register
  assign out = shift_reg[3];

  // Sequential logic for the shift register
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      // Reset the shift register to all zeros
      shift_reg <= 4'b0000;
    end else begin
      // Shift the register one position to the right, and load the new input into the LSB
      shift_reg <= {in, shift_reg[3:1]};
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
