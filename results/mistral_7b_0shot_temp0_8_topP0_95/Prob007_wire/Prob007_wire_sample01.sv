
module TopModule (
  input wire in,
  output reg out
);

always @(posedge clk)
begin
  out <= in;
end

initial begin
  #10 $finish; // Optionally, you can specify a simulation time for the testbench to run for a specific number of clock cycles.
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
