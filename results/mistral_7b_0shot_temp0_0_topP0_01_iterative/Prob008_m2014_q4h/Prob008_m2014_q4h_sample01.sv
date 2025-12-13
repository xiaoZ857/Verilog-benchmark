
module TopModule (
  input in,
  output out
);
wire out_wire; // Declare a wire for output to fix the error

always @(posedge clk or posedge in) begin
  if (in)
    out_wire <= in;
end

assign out = out_wire; // Assign output directly to the wire

endmodule
