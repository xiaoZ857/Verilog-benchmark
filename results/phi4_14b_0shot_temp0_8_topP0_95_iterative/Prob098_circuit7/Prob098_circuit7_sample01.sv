
module TopModule (
  input clk,
  input a,
  output reg q
);
always @(posedge clk) begin
    if (a == 0) begin
        q <= 1; // Set q to 1 when a is 0
    end else if (a == 1) begin
        q <= ~q; // Toggle q on each positive edge of the clock when a is 1
    end
end

endmodule
