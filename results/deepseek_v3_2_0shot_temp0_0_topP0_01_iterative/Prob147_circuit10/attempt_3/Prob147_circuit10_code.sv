
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
always @(posedge clk) begin
    if (a == b) begin
        state <= q ? ~state : state;
    end
end

assign q = state ? (a & ~b) : (~a & b);

// VERILOG-EVAL: endmodule not found
