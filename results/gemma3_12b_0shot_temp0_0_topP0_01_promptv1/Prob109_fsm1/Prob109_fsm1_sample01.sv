
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
reg state;
reg out_reg;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 1'b1;
  end else begin
    case (state)
      1'b0: begin
        if (in == 0)
          state <= 1'b1;
        else
          state <= 1'b0;
      end
      1'b1: begin
        if (in == 0)
          state <= 1'b0;
        else
          state <= 1'b1;
      end
    endcase
  end
end

assign out = state;
endmodule
