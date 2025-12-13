
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);

  reg q;
  
  always @(posedge clk) begin
    if (a == 1 && b == 0) begin
      q <= 0;
    end else if (a == 0 && b == 0) begin
      q <= 0;
    end else if (a == 1 && b == 1) begin
      q <= 0;
    end else if (a == 0 && b == 1) begin
      q <= 1;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
