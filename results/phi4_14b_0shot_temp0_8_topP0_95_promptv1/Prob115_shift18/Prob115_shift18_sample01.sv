
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
    if (load)
        shift_reg <= data;
    else if (ena)
        case (amount)
            2'b00: shift_reg <= {shift_reg[62:0], 1'b0}; // Shift left by 1 bit
            2'b01: shift_reg <= {shift_reg[55:0], 8'b0}; // Shift left by 8 bits
            2'b10: shift_reg <= {{7{shift_reg[63]}}, shift_reg[63:1]}; // Arithmetic right shift by 1 bit
            2'b11: shift_reg <= {{56{shift_reg[63]}}, shift_reg[63:8]}; // Arithmetic right shift by 8 bits
        endcase
end

always @(posedge clk) begin
    q <= shift_reg;
end

endmodule
