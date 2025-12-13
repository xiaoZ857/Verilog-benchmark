
module TopModule (
  input wire clk,
  input wire areset,
  input [7:0] d,
  output reg [7:0] q
);

// Instantiate 8 D flip-flops with active high asynchronous reset
always @(posedge clk or negedge areset) begin
  if (areset) begin
    q <= 8'b0; // Reset all DFFs to 0 when areset is high
  end else begin
    q <= d; // Assign the value of 'd' to 'q' on positive edge of clk
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
