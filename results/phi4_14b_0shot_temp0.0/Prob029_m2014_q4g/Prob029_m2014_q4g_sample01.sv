

module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);

  always_ff @(posedge clk) begin
    logic xnor_out;
    
    // XNOR operation on in1 and in2
    assign xnor_out = ~(in1 ^ in2);

    // XOR operation between the result of XNOR and in3
    assign out = xnor_out ^ in3;
  end

endmodule
