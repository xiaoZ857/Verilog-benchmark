
module TopModule (
  input in,
  output out
);
module not_gate (
    input clk, // Positive edge trigger
    input in,   // Input to the NOT gate
    output out  // Output of the NOT gate
);

    always @(posedge clk) begin
        // The output of a NOT gate is the inverse of the input
        out <= ~in;
    end
endmodule
