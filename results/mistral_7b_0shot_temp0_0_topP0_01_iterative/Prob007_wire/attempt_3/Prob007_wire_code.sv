
module TopModule (
  input in,
  output out
);
always @(posedge clk) begin
  out <= in;
end

// Add timescale directive outside the module definition
`timescale 1ns / 1ps

// End of module body with endmodule
initial begin
  $finish;
end

endmodule
