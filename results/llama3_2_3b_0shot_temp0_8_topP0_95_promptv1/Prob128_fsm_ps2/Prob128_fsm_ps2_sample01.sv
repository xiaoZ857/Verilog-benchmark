
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
assign out = (in[2] == 1'b1) && (!(in[3] == 1'b1));
assign done = out && (in[1] == 1'b1) && (in[0] == 1'b1);
always @(posedge clk) begin
    if (reset)
        out <= 1'b0;
    else
        out <= !((in[2] == 1'b1) && (!(in[3] == 1'b1)));
end

assign done = done || reset;

// VERILOG-EVAL: endmodule not found
