
module TopModule (
  input clk,
  input in,
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
        if (in == 0)
          state <= 1;
        else
          state <= 0;
      end
      1: begin
        if (in == 0)
          state <= 1;
        else
          state <= 0;
      end
    endcase
  end
end

assign out = (state == 0) ? 0 : 1;
endmodule
