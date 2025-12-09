
module TopModule (
  input wire clk,
  input wire resetn, // Active-low synchronous reset
  input wire in,
  output wire out
);

  reg [3:0] shift_reg; // 4-bit register to hold the state of the shift register

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      // Asynchronous active-low reset
      shift_reg <= 4'b0000;
    end else begin
      // Shift operation: left with input being fed into the least significant bit
      shift_reg <= {shift_reg[2:0], in};
    end
  end

  assign out = shift_reg[3]; // Output is the most significant bit of the register

endmodule

// VERILOG-EVAL: errant inclusion of module definition
