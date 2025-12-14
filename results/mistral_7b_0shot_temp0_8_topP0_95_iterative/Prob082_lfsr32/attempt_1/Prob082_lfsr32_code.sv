
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);

always @(posedge clk) begin
  if (reset)
    q <= 32'h1;
  else begin
    q[31] <= q[30];
    q[22] <= q[21] ^ q[0];
    q[ 2] <= q[1] ^ q[0];
    q[ 1] <= q[0];
  end
end

assign q_out = q; // Extract output if needed

endmodule

// VERILOG-EVAL: errant inclusion of module definition
