
module TopModule (
  input clk,
  input j,
  input k,
  output reg Q
);

always @(posedge clk) begin
    case ({j, k})
        2'b00: Q <= Q;       // J = 0, K = 0: No change (retains Qold)
        2'b01: Q <= 1'b0;    // J = 0, K = 1: Reset to 0
        2'b10: Q <= 1'b1;    // J = 1, K = 0: Set to 1
        2'b11: Q <= ~Q;      // J = 1, K = 1: Toggle
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
