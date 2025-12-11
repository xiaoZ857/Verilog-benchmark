
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
 ```verilog
always @(posedge clk or negedge areset) begin
    if (areset)
        out <= 1'b0;
    else if (in == areset)
        out <= 1'b1;
    else if (in == out)
        out <= 1'b0;
    else
        out <= 1'b1;
end
assign out_wire = out;
endmodule

// VERILOG-EVAL: abnormal backticks count
