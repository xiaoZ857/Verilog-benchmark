
module TopModule (
  output logic zero
);

always @(posedge clk)
begin
  zero <= 0;
end

// Add clock input if not provided
// input clock clk;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
