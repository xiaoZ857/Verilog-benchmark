
module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output reg out
);

always @(posedge clk) begin
  if(sel[7])
    out <= in[sel[6] + 128];
  else if (sel[6])
    out <= in[sel[5] + 256];
  else if (sel[5])
    out <= in[sel[4] + 512];
  else if (sel[4])
    out <= in[sel[3] + 768];
  else if (sel[3])
    out <= in[sel[2] + 1024];
  else if (sel[2])
    out <= in[sel[1] + 1280];
  else if (sel[1])
    out <= in[sel[0] + 1536];
  else
    out <= in[0]; // sel[0] should select in[0]
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
