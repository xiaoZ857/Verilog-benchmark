
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
 ```verilog
always @(posedge clk) begin
    for (int i = 0; i < 8; i++) begin
        if (in[i] && ~pedge[i])
            pedge[i] <= !pedge[i]; // set output the cycle after a 0 to 1 transition occurs
    end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
