
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
reg [7:0] prev_in;

always_ff @(posedge clk) begin
    pedge <= in & ~prev_in;   // set bit when 0→1 transition occurs
    prev_in <= in;            // store current input for next cycle
end

endmodule
