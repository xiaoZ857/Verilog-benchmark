
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
always @(posedge clk) begin
    if (reset) begin
        done <= 1'b0;
    end else begin
        done <= 1'b0;
    end
end
endmodule
