
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
assign out = {in[3:0], out[3:1]};

always @(posedge clk) begin
    if (resetn == 1)
        out <= 4'b0000;
    else
        out <= {in, out};
end

// VERILOG-EVAL: endmodule not found
