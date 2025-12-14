
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
  reg [3:1] next_y;

  always @(y, w) begin
    case (y[3:1])
      4'b0000: // State A
        if (w == 0)
          next_y = 4'b0000;
        else
          next_y = 4'b0000;
      4'b0001: // State B
        if (w == 0)
          next_y = 4'b0010;
        else
          next_y = 4'b0001;
      4'b0010: // State C
        if (w == 0)
          next_y = 4'b0100;
        else
          next_y = 4'b0011;
      4'b0011: // State D
        if (w == 0)
          next_y = 4'b0101;
        else
          next_y = 4'b0000;
      4'b0100: // State E
        if (w == 0)
          next_y = 4'b0100;
        else
          next_y = 4'b0011;
      4'b0101: // State F
        if (w == 0)
          next_y = 4'b0101;
        else
          next_y = 4'b0000;
      default:
        next_y = 4'b0000;
    endcase
    Y2 = next_y[2];
  end

// VERILOG-EVAL: endmodule not found
