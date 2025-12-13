
module TopModule (
  input [7:0] in,
  output reg [31:0] out
);

// Create a constant for the number of replications
parameter N = 24;

// Create a helper module to replicate the sign bit
module sign_extender (
  input wire sig,
  output reg [N-1:0] extended
);

assign extended[0] = sig;
always @(posedge clk) begin
  for (int i = 1; i < N; i++)
    extended[i] = sig;
end

// Instantiate the helper module four times to cover all bits of the input
sign_extender se0 (in[7], out[31:24]);
sign_extender se1 (in[6], out[23:16]);
sign_extender se2 (in[5], out[15:8]);
sign_extender se3 (in[4], out[7:0]);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
