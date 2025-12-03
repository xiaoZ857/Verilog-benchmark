

module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else if (ena) begin
    case (amount)
      2'b00: begin // Shift left by 1
        q <= {q[62:0], 1'b0};
      end
      2'b01: begin // Shift left by 8
        q <= {q[55:0], 8'b0};
      end
      2'b10: begin // Shift right by 1 (arithmetic)
        q <= {q[62:1], 1'b0};
      end
      2'b11: begin // Shift right by 8 (arithmetic)
        q <= {q[55:0], 8'b0};
      end
      default: begin
        q <= q;
      end
    endcase
  end else begin
    q <= q;
  end
endmodule
