
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
assign out = in & ~a;

always @(posedge clk or negedge areset) begin
    if (areset)
        out <= 1'b0;
    else
        out <= in;
end

// VERILOG-EVAL: endmodule not found
