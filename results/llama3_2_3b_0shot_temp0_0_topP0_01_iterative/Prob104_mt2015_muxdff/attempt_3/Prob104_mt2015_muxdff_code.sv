
module TopModule (
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg [2:0] Q
);

assign Q = (L) ? r_in : q_in;

always @(posedge clk) begin
  if (L) begin
    Q <= r_in;
  end else begin
    Q <= {Q[1], Q[0], Q[2]};
  end
endmodule

// VERILOG-EVAL: errant inclusion of module definition
