
module TopModule (
  input clk,
  input in,
  output logic out
);
  logic d_input;
  
  assign d_input = in ^ out;
  
  always_ff @(posedge clk) begin
    out <= d_input;
  end
  
  // Initialize output to 0 at time 0
  initial begin
    out = 1'b0;
  end
endmodule
