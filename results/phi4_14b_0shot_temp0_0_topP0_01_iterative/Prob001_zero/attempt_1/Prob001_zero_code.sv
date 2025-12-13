
module TopModule (
  output reg zero // Use 'reg' because we are assigning a continuous value
);

  initial begin
    zero = 1'b0; // Assign low (0) to the output
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
