
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
logic state;

always @(posedge clk) begin
  if (reset) begin
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
      default: state <= 0;
    endcase
  end
end

assign out = state == 1;

endmodule
