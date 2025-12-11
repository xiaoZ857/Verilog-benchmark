
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
assign z = (x == 1) ? (z != 1) : (z && x == 1);

always @(posedge clk)
begin
    if (!aresetn)
        z <= 0;
    else if (z == 0 && x == 1)
        z <= 1;
    else if (z == 1 && x == 1)
        z <= 1;
end

always @(*) begin
    if (x == 0)
        z <= 0;
end

// VERILOG-EVAL: endmodule not found
