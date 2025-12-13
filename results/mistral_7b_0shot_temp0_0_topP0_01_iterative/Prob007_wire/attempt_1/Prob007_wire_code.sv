
module TopModule (
  input wire in,
  output reg out
);

always @(posedge clk) begin
  out <= in;
end

initial begin
  $finish;
end

// Add clock input if needed
// module TopModule (
//   input wire in,
//   input wire clk,
//   output reg out
// );
// always @(posedge clk) begin
//   out <= in;
// end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
