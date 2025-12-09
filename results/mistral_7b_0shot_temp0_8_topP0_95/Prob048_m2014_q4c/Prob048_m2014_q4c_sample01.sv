
module TopModule (
  input clock,
  input data,
  input reset,
  output reg q
);

always @(posedge clock) begin
  if (reset)
    q <= 0;
  else
    q <= data;
end

assign q_bar = !q; // Providing the complement of 'q' as 'q_bar' for convenience

endmodule

// VERILOG-EVAL: errant inclusion of module definition
