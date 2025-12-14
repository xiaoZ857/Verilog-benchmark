
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);

always @ (posedge clk) begin
    if (reset) begin
        q[0] <= 0;
        q[1] <= 0;
        q[2] <= 0;
        q[3] <= 0;
    end else begin
        q[0] <= !q[0];  // LSB toggles on each clock cycle
        q[1] <= q[0];   // Each higher bit toggles when the lower bit overflows (handled in next lines)
        q[2] <= q[1];
        q[3] <= q[2];
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
