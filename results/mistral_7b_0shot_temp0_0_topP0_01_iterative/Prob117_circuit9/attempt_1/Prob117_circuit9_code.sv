
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

always @(posedge clk) begin
  if (a) begin
    if (q == 5'b10010) begin
      q <= 3'b000; // reset counter when counting from 6 to 0
    end
    else begin
      q <= q + 1; // increment counter when counting up
    end
  end
  else begin
    q <= 3'b000; // reset counter when a is low
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
