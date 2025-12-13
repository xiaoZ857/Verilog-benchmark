
module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output reg out
);

always @* 
begin
  out = in[sel];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
