
module TopModule (
  output out
);

always_comb begin
  out <= 0;
end

initial begin
  $finish; // This is just for simulation, it will terminate the simulation immediately.
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
