
module TopModule (
  input clk,
  input resetn,
  input in,
  output reg [3:0] out
);

reg [3:0] q[4:0];

always @(posedge clk) begin
  if (!resetn) begin
    // Reset the shift register on rising edge of clock when resetn is low
    q <= 4'd0;
  end else begin
    // Shift in new data on rising edge of clock
    q[4] <= in;
    q[3] <= q[4];
    q[2] <= q[3];
    q[1] <= q[2];
    q[0] <= q[1];
  end
end

assign out = q[0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
