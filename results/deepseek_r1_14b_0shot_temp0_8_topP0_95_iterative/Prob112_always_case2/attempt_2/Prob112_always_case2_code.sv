
$timescale 1ns / 1ps

module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);

always @* begin
  case (in)
    4'b1??? : pos = 2'b10; // Check MSB first
    4'b?1?? : pos = 2'b01;
    4'b??1? : pos = 2'b00; // Wait, this might not be correct.
    default : pos = 0;
  endcase
end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
