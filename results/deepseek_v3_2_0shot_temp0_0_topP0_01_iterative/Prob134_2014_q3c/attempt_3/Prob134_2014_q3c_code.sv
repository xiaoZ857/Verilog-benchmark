
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
  always @(posedge clk) begin
    case(y)
      3'b000: begin
        Y0 <= x ? 1'b1 : 1'b0;  // x=0:000->Y0=0, x=1:001->Y0=1
        z <= 1'b0;
      end
      3'b001: begin
        Y0 <= x ? 1'b0 : 1'b1;  // x=0:001->Y0=1, x=1:100->Y0=0
        z <= 1'b0;
      end
      3'b010: begin
        Y0 <= x ? 1'b1 : 1'b0;  // x=0:010->Y0=0, x=1:001->Y0=1
        z <= 1'b0;
      end
      3'b011: begin
        Y0 <= x ? 1'b0 : 1'b1;  // x=0:001->Y0=1, x=1:010->Y0=0
        z <= 1'b1;
      end
      3'b100: begin
        Y0 <= x ? 1'b0 : 1'b1;  // x=0:011->Y0=1, x=1:100->Y0=0
        z <= 1'b1;
      end
      default: begin
        Y0 <= 1'b0;
        z <= 1'b0;
      end
    endcase
  end
endmodule

// VERILOG-EVAL: abnormal backticks count
