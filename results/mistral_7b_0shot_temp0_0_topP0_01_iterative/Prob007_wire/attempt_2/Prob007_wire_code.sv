
always @(posedge clk) begin
  out <= in;
end

initial begin
  $finish;
end

// Add timescale directive outside the module definition
`timescale 1ns / 1ps

module TopModule (
  input in,
  output out
);

// End of module body with endmodule
endmodule

// VERILOG-EVAL: errant inclusion of module definition
