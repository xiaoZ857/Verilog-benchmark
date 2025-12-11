
module TopModule (
  input [31:0] in,
  output [31:0] out
);
 ```verilog
reg [31:0] temp [7:0];
always @(posedge clk) begin
    for (int i = 0; i < 8; i++)
        temp[i] = in[(31-i)*4 + 3]; // Extract byte at position 'i' and store it into temp array
    out = {temp[7], temp[6], temp[5], temp[4], temp[3], temp[2], temp[1], temp[0]}; // Reorder bytes and assign to output
end
endmodule

// VERILOG-EVAL: abnormal backticks count
