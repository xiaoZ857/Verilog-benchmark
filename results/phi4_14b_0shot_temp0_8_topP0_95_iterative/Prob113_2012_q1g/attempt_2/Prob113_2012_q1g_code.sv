
module TopModule (
  input [4:1] x,
  output logic f
);

  always_comb begin
    f = (~x[4] & ~x[3] & ~x[2] & ~x[1]) | 
        (~x[4] &  x[3] & ~x[2] &  x[1]) |
        (~x[4] &  x[3] &  x[2] & ~x[1]) |
        (~x[4] &  x[3] &  x[2] &  x[1]) | 
        ( x[4] & ~x[3] &  x[2] & ~x[1]) | 
        ( x[4] & ~x[3] &  x[2] &  x[1]) | 
        ( x[4] &  x[3] & ~x[2] & ~x[1]) |
        ( x[4] &  x[3] & ~x[2] &  x[1]);
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
