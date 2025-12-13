
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
reg [3:0] q_reg;
reg [3:0] temp_q;

always @(posedge clk) begin
  if (areset) begin
    q_reg <= 4'b0000;
    temp_q <= 4'b0000;
  end else if (load && !ena) begin
    q_reg <= data;
    temp_q <= data;
  end else if (ena) begin
    temp_q[3] <= 1'b0;
    temp_q <= temp_q[2:0];
  end
end

assign q = q_reg;

endmodule
