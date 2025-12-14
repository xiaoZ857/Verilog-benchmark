
// ab
cd   00  01  11  10
// 00 | 0 | 1 | 0 | 1 |
// 01 | 1 | 0 | 1 | 0 |
// 11 | 0 | 1 | 0 | 1 |
// 10 | 1 | 0 | 1 | 0 |

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

  always_comb
    case (a, b)
      // 00
      default: 
        if (d == 0) out = 0;
        else          out = 1;

      // 01
      0:           out = 0;
      1:           out = 1; 

      // 11
      1:           out = 1;
      default: 
        if (d == 0) out = 0;
        else          out = 1;

      // 10
    endcase

endmodule

// VERILOG-EVAL: errant inclusion of module definition
