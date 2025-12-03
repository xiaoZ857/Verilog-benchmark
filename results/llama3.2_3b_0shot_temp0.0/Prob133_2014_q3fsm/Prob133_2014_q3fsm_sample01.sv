

module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

always @(posedge clk)
begin
    if (reset) 
        z <= 0;
    else if (!s && w == 1)
        z <= 1;
    else if (!s && w == 0)
        z <= 0;
    else if (s && w == 1)
        z <= 1;
end

always @(posedge clk)
begin
    if (z == 1) 
        z <= 0;
end

// VERILOG-EVAL: endmodule not found
