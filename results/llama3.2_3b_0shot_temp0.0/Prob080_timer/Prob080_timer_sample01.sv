

module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);

always @(posedge clk)
begin
    if (load == 1)
        tc <= 1;
    else
        if (tc == 0)
            tc <= 1;
        else
            tc <= tc - 1;
end

// VERILOG-EVAL: endmodule not found
