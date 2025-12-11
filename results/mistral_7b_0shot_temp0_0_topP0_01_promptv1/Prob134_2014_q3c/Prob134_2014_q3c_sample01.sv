
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
 ```verilog
always @(posedge clk) begin
    if (x) begin
        case (y)
            000: Y0 <= 0'b0;
            001: Y0 <= 1'b0;
            010: Y0 <= 0'b0;
            011: Y0 <= 1'b0;
            100: Y0 <= 1'b1;
            default: Y0 <= 0'bx; // x is unknown value, set output to unknown
        endcase
    end
    assign z = (y[2] ^ y[1]) & ~y[0];
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
