
module TopModule (
  input [7:0] code,
  output reg [3:0] out,
  output reg valid
);

always @(posedge clk) begin
  case (code)
    8'h45 : out <= 4'b0; valid <= 1'b1;
    8'h16 : out <= 4'b1; valid <= 1'b1;
    8'h1e : out <= 4'b2; valid <= 1'b1;
    8'h26 : out <= 4'b3; valid <= 1'b1;
    8'h25 : out <= 4'b4; valid <= 1'b1;
    8'h2e : out <= 4'b5; valid <= 1'b1;
    8'h36 : out <= 4'b6; valid <= 1'b1;
    8'h3d : out <= 4'b7; valid <= 1'b1;
    8'h3e : out <= 4'b8; valid <= 1'b1;
    8'h46 : out <= 4'b9; valid <= 1'b1;
    default : out <= 4'b0; valid <= 1'b0;
  endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
