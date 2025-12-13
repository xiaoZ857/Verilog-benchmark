
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
always @(posedge clk) begin
    if (in[3] == 1)
        pos <= 2'b11; // If bit 3 is set, position is 3
    else if (in[2] == 1)
        pos <= 2'b10; // If bit 2 is set, position is 2
    else if (in[1] == 1)
        pos <= 2'b01; // If bit 1 is set, position is 1
    else if (in[0] == 1)
        pos <= 2'b00; // If bit 0 is set, position is 0
    else
        pos <= 2'b00; // If none of the bits are set, position is 0
end

// Add clock enable (ce) if needed: always @(posedge clk) if (ce) pos <= ...

endmodule
