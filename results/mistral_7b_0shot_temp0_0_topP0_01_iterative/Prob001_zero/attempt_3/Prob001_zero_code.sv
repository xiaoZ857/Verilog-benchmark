
module TopModule (
  output zero
);
always @(posedge clk)
begin
  zero <= 0;
end

// Add clock input if not provided
input logic clk;

endmodule
