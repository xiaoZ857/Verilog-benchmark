
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
always @(posedge clk) begin
    if (reset)
        out <= 1'b0;
    else begin
        case (out)
            1'b0: if (j) out <= 1'b1;
            1'b1: if (k) out <= 1'b0;
        endcase
    end
end
endmodule
