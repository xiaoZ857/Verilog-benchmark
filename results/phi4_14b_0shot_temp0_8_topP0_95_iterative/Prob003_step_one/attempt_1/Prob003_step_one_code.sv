
module TopModule (
  output reg one // Use 'reg' type as we'll be assigning a value to it
);

  initial begin
    one = 1; // Assign logic high to the output
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
