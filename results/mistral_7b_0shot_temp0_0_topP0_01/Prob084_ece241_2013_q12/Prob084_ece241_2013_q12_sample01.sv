

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
reg [7:0] shift_register;

always @(posedge clk) begin
  if (enable)
    shift_register <= {shift_register[6], S, shift_register[1:0]};
end

assign Z = shift_register[(A & B & C) + 1];

endmodule

// VERILOG-EVAL: abnormal backticks count
