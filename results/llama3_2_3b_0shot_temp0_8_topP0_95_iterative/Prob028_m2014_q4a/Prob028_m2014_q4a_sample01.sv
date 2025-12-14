
module TopModule (
  input d,
  input ena,
  output logic q
);
always @(posedge clk) begin
    if (ena == 1'b1) begin
        q <= d;
    end else begin
        q <= q && d; // Metastable mode
    end
endmodule
