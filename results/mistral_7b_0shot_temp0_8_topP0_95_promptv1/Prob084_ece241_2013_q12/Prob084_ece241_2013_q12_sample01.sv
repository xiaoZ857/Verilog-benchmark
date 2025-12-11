
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
reg [7:0] shift_reg;
always @(posedge clk) begin
    if (enable)
        shift_reg <= {shift_reg[6:0], S};
end

assign Z = (A & B & C)? shift_reg[(A+B+C)-1] : shift_reg[0];
endmodule

// VERILOG-EVAL: abnormal backticks count
