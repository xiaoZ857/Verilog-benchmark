
module TopModule (
  input wire in,
  output wire out
);

always @(posedge clk) begin
  out <= in;
end

initial begin
  $finish; // Exits the simulation once the initial block is completed.
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
