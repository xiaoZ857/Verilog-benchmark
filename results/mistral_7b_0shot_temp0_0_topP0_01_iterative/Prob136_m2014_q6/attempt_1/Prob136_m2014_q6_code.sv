
module TopModule (
  input clk,
  input reset,
  input w,
  output reg z
);

reg A, B, C, D, E, F;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    A <= 0;
    B <= 0;
    C <= 0;
    D <= 0;
    E <= 0;
    F <= 0;
  end else begin
    case ({A, B, C, D})
      2'b0000: begin
        if (w) A <= 1;
        else A <= 0;
      end,
      2'b0001: begin
        A <= A;
      end,
      2'b0010: begin
        if (w) B <= 1;
        else B <= 0;
      end,
      2'b0011: begin
        B <= B;
      end,
      2'b0100: begin
        if (w) C <= 1;
        else C <= 0;
      end,
      2'b0101: begin
        C <= C;
      end,
      2'b0110: begin
        if (w) D <= 1;
        else D <= 0;
      end,
      2'b0111: begin
        D <= A;
      end,
      2'b1000: begin
        E <= E;
      end,
      2'b1001: begin
        if (!w) E <= 1;
        else E <= 0;
      end,
      2'b1010: begin
        F <= C;
      end,
      2'b1011: begin
        if (!w) F <= 1;
        else F <= 0;
      end,
      default: z <= 1'bx; // Unreachable state
    endcase
    z <= ~D;
  end
end

initial begin
  clk = 0;
  #5 clk = ~clk;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
