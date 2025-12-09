
module TopModule (
  input wire clk,
  input wire a,
  output reg q
);

always @(posedge clk) begin
  if (a) begin
    q <= q; // No change when a is high
  end else begin
    q <= ~q; // Toggle q when a is low
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
