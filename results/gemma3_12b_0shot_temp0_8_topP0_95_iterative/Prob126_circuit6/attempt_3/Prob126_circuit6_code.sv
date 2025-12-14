
module TopModule (
  input [2:0] a,
  output reg [15:0] q
);
  always @(a) begin
    case (a)
      0: q = 1232;
      1: q = 65535;
      2: q = 4;
      3: q = 5248;
      4: q = 2066;
      5: q = 10014;
      6: q = 3646;
      7: q = 6860;
      default: q = 0; // Default case for unknown inputs
    endcase
  end

endmodule
