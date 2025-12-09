
module TopModule (
  input d,
  input ena,
  output logic q
);

  always_ff @ (posedge clk or negedge reset_n) begin
    if (!reset_n)
      q <= 1'b0; // Optional: Reset logic to initialize `q` to a known state
    else if (ena)
      q <= d;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
