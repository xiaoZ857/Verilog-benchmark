
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
  reg [99:0] reg_q;

  always @(posedge clk) begin
    if (load) begin
      reg_q <= data;
    end else begin
      case (ena)
        2'b01: begin // Rotate right by one bit
          reg_q <= {reg_q[98:0], reg_q[99]};
        end
        2'b10: begin // Rotate left by one bit
          reg_q <= {reg_q[99], reg_q[98:0]};
        end
        default: begin // No rotation
          reg_q <= reg_q;
        end
      endcase
    end
  end

  assign q = reg_q;

endmodule
