
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
always @ (posedge clk) begin
    case ({a, b, c, d})
        4'b00xx: out = 1'b0; // For cd = 00, any value of ab results in 0
        4'b01xx: 
            if (c == 1'b0 && d == 1'b0) out = 1'b0;
            else out = 1'bx; // Don't care for other combinations when cd = 01
        4'b11xx: out = 1'b1; // For cd = 11, any value of ab results in 1
        4'b10xx: out = 1'b1; // For cd = 10, any value of ab results in 1
        default: out = 1'bx; // Default case for don't-care values
    endcase
end

endmodule
