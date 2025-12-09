
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);
  
  // AND gate output
  reg out_and;
  always @* begin
    out_and = 1;
    for (integer i = 0; i < 100; i++) begin
      out_and = out_and & in[i];
    end
  end

  // OR gate output
  reg out_or;
  always @* begin
    out_or = 0;
    for (integer i = 0; i < 100; i++) begin
      out_or = out_or | in[i];
    end
  end

  // XOR gate output
  reg out_xor;
  always @* begin
    out_xor = 0;
    for (integer i = 0; i < 100; i++) begin
      out_xor = out_xor ^ in[i];
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
