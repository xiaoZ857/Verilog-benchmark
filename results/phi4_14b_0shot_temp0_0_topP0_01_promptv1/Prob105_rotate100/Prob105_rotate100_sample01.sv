
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
reg [99:0] shift_reg;

always @(posedge clk) begin
    if (load)
        shift_reg <= data;
    else begin
        case (ena)
            2'b01: shift_reg <= {shift_reg[98:0], shift_reg[99]};
            2'b10: shift_reg <= {shift_reg[0], shift_reg[99:1]};
            default: shift_reg <= shift_reg;
        endcase
    end
end

always @(posedge clk) begin
    q <= shift_reg;
end

endmodule
