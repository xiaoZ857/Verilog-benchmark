
module TopModule (
  input [7:0] code,
  output reg [3:0] out,
  output reg valid
);

assign valid = (code == 8'h45 || code == 8'h16 || code == 8'h1e || code == 8'h26 ||
                code == 8'h25 || code == 8'h2e || code == 8'h36 || code == 8'h3d ||
                code == 8'h3e || code == 8'h46);

always @(posedge clk) begin
    if (valid) begin
        case (code)
            8'h45: out <= 4'b0001;
            8'h16: out <= 4'b0010;
            8'h1e: out <= 4'b0011;
            8'h26: out <= 4'b0100;
            8'h25: out <= 4'b0101;
            8'h2e: out <= 4'b0110;
            8'h36: out <= 4'b1000;
            8'h3d: out <= 4'b1001;
            8'h3e: out <= 4'b1010;
            8'h46: out <= 4'b1011;
            default : out <= 4'b0000;
        endcase
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
