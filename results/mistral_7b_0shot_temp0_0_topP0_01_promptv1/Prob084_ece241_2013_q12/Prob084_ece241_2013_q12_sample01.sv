
module TopModule (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);
 ```verilog
reg [7:0] data;
always @(posedge clk) if (enable)
    begin
        data <= {S, data[1:7]};
    end
assign Z = data[A + B*8 + C*8*7];
endmodule

// VERILOG-EVAL: abnormal backticks count
