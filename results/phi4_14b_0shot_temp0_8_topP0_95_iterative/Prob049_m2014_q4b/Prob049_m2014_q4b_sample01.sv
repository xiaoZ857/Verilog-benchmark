
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

  always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
      q <= 1'b0; // Asynchronous reset, reset `q` to 0
    end else begin
      q <= d; // On the positive edge of clock, load `d` into `q`
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
