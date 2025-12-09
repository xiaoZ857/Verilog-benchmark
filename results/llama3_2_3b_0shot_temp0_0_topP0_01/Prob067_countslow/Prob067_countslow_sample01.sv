

module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);

reg [3:0] q;
always @(posedge clk or posedge slowena) begin
    if (slowena) 
        q <= 0;
    else if (q == 9)
        q <= 0;
    else
        q <= q + 1;
end

assign q = q;

// VERILOG-EVAL: endmodule not found
