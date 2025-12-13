
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    out <= 4'b0001; // Reset value
  end else begin
    out <= {out[1:3], in}; // Shift remaining bits to the left and insert new input
  end
end

assign out = out[3:0]; // Reorder output bits for convenience

endmodule
