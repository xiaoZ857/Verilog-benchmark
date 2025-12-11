
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
logic state;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 0;
  end else begin
    case (state)
      0: begin
        if (j)
          state <= 1;
        else
          state <= 0;
      end
      1: begin
        if (k)
          state <= 0;
        else
          state <= 1;
      end
    endcase
  end
end

assign out = state;
endmodule
