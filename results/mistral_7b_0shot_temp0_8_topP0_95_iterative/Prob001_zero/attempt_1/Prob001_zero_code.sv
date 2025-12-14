
module TopModule (
  output reg zero
);

always @(posedge clk)
begin
  // Default case, since no else clause is provided, this will be executed always
  zero <= 0;
end

// You can add a clock input if needed:
input wire clk;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
