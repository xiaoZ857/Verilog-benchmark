
module TopModule (
  input clk,
  input d,
  output reg q
);

always @(posedge clk) begin
    if (negedge clk) begin
        q <= d;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
