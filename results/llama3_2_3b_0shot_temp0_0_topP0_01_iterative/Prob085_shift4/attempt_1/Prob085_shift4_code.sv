
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

reg [3:0] q_reg;

always @(posedge clk) begin
  if (areset) begin
    q_reg <= 4'b0000;
  end else if (load && !ena) begin
    q_reg <= data;
  end else if (ena) begin
    q_reg[3] <= 1'b0;
    q_reg <= q_reg[2:0];
  end
end

assign q = q_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
