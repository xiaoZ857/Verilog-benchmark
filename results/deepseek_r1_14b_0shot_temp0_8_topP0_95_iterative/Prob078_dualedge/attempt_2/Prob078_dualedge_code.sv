
module TopModule (
  input clk,
  input d,
  output reg q
);

always @(posedge clk) 
begin
    q <= d;
end

always @(negedge clk)
begin
    q <= d; // Both edges will set q to d when they occur
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
