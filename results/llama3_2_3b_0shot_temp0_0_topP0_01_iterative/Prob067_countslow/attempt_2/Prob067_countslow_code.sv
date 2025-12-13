
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);

reg [5:0] count; // 6-bit counter to hold the decimal value

always @(posedge clk) begin
  if (reset) begin
    count <= 0;
  end else if (slowena) begin
    count <= count + 1;
  end else begin
    count <= count + 1;
  end
end

assign q = count[3:0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
