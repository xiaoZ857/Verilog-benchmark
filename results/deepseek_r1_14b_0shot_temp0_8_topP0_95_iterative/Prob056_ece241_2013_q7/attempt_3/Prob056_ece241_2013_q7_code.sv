
module TopModule (
  input clk,
  input j,
  input k,
  output reg Q
);
  
always @(posedge clk) 
begin
    case ({j, k})
        2'b00: Q <= #1 Q;    // J=0, K=0: Q remains same as Qold
        2'b01: Q <= #1 0;    // J=0, K=1: Q becomes 0
        2'b10: Q <= #1 1;    // J=1, K=0: Q becomes 1
        default: Q <= #1 ~Q; // J=1, K=1: Q toggles (same as ~Qold)
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
