
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
assign out = $signed(in) ? 1'b1 : 1'b0;

always @(posedge clk or posedge reset) begin
    if (reset)
        out <= 1'b0;
    else
        case ($signed(in))
            2'b00: out <= 1'b0;
            2'b01: out <= 1'b0;
            2'b10: out <= 1'b1;
            2'b11: out <= 1'b1;
        endcase
end

// VERILOG-EVAL: endmodule not found
