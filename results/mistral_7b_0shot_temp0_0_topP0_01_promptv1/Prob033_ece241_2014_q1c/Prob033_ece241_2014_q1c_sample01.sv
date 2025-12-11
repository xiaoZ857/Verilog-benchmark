
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
 ```verilog
reg [7:0] temp_sum;
always @(posedge clk) begin
    if (overflow_last)
        temp_sum <= a + b - 2'b1111_1111; // subtract maximum value to check for overflow
    else
        temp_sum <= a + b;
    s <= temp_sum;
    overflow <= (temp_sum > 'hFF) ^ (temp_sum < '00); // compare with zero and maximum value
end
assign overflow_last = overflow;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
