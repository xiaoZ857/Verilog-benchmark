
module TopModule (
  input wire clk,
  input wire reset,
  output reg [9:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 0;
  end else begin
    if (q < 999) begin
      q <= q + 1;
    end else begin
      q <= 0; // Reset the counter when it reaches 1000
    end
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
