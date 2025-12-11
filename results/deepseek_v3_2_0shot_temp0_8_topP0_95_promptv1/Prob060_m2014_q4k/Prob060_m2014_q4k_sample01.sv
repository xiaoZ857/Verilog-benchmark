
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
always @(posedge clk) begin
    if (!resetn) begin
        out <= 1'b0;
    end else begin
        out <= in;
    end
end
endmodule
