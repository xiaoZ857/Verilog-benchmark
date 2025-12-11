
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
always @(posedge clk) begin  
    if (reset)
        q <= 4'b0000;
    else if (slowena)
        q <= q + 1'b1;
end

assign q_next = (q == 4'd9) ? 4'b0000 : q + 1'b1;

always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else if (slowena)
        q <= q_next;
end

endmodule
