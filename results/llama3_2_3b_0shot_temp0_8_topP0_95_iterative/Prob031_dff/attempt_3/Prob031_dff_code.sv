
module TopModule (
  input clk,
  input d,
  output reg q
);

assign q = d;

initial begin
    $resetforalways
    q <= 1'b0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
