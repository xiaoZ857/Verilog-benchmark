
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
wire [511:0] next_q;
assign next_q = (q >> 1) ^ (q << 1);

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_q;
end

endmodule
