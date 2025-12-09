
module TopModule (
  input wire clk,
  input wire reset,
  output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0001; // Reset the counter to 0001 (decimal 1)
  end else begin
    q <= q + 1; // Increment the counter on each positive clock edge
  end
end

always @(posedge clk negedge reset) begin
  if (reset) begin
    $finish; // Stop simulation when reset is active to allow observing the initial state
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
