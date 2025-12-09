
// Define the boolean function z
module TopModule (
  input x,
  input y,
  output z
);

    // Create an internal expression for z using XOR and AND operators
    always @(posedge clk) begin
        z = ((x ^ y) & x);
    end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
