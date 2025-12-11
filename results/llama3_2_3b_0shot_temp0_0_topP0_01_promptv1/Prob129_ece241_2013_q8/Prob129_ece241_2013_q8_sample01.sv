
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
assign z = (x & ~z) | (~x & z);

always @(posedge clk or negedge aresetn)
begin
    if (!aresetn)
        z <= 1'b0;
    else if ((x & ~z) && (~x & z))
        z <= 1'b1;
end

// VERILOG-EVAL: endmodule not found
