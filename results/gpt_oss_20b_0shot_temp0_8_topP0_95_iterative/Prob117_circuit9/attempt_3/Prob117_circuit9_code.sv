
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
    if (a)
        q <= 3'd4;          // Set to binary 100 when a is high
    else
        q <= q + 1;         // Increment modulo 8 when a is low
end

endmodule
