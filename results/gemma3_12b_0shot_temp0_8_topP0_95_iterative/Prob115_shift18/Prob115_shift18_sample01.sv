
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
  reg [63:0] shift_reg;

  always @(posedge clk) begin
    if (load) begin
      shift_reg <= data;
    end else if (ena) begin
      case (amount)
        2'b00: shift_reg <= {shift_reg[62:0], shift_reg[0]}; // Shift left by 1
        2'b01: shift_reg <= {shift_reg[62:0], {8{shift_reg[0]}}}; // Shift left by 8
        2'b10: shift_reg <= {shift_reg[62], shift_reg[62:1]}; // Arithmetic shift right by 1.  Sign extension.
        2'b11: shift_reg <= {shift_reg[62], {8{shift_reg[62]}}}; // Arithmetic shift right by 8. Sign extension.
        default: shift_reg <= shift_reg; // No shift, keep the current value
      endcase
    end else begin
      shift_reg <= shift_reg; // keep the current value
    end
  end

  assign q = shift_reg;
endmodule
