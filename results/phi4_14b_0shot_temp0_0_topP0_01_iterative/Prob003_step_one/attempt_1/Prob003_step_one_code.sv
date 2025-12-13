
module TopModule (
  output reg one // Use 'reg' because we're driving a continuous value
);

  always @(*) begin
    one = 1'b1; // Assign logic high to the output
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
