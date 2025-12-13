
module TopModule (
  input [4:1] x,
  output logic f
);

assign f = x[1] & ~x[2] | x[3];

// Alternatively, using a case statement for readability
always_comb begin
  case(x)
    4'b0001: f = 1'b0;
    4'b0010: f = 1'b1;
    4'b0111: f = 1'b1;
    4'b1010: f = 1'b1;
    default : f = 1'b0;
  endcase
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
