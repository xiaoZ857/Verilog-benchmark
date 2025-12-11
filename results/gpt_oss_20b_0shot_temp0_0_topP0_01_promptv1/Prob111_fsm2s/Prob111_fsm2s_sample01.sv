
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
reg state;

always @(posedge clk) begin
    if (reset)
        state <= 1'b0;
    else begin
        case (state)
            1'b0: state <= j;
            1'b1: state <= k;
        endcase
    end
end

assign out = state;

endmodule
