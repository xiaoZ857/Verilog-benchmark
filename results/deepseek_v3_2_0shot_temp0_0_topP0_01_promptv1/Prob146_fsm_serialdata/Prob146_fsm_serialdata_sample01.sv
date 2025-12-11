
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
always @(posedge clk) begin
    if (reset) begin
        out_byte <= 8'b0;
        done <= 1'b0;
    end else begin
        done <= 1'b0;
    end
end

endmodule
