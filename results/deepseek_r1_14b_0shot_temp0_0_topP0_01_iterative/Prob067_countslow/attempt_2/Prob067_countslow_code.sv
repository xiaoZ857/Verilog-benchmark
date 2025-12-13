
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
input clk,
input slowena,
input reset,
output reg [3:0] q
);

// Implement counter logic here

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end else if (slowena) begin
        if (q == 9) begin
            q <= 0;
        end else begin
            q <= q + 1;
        end
    end
end

endmodule
