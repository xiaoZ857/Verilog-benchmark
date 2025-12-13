
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  // Internal register to hold the state of the flip-flops
  reg [7:0] ff;

  always @(negedge clk) begin
    if (reset) begin
      // Synchronously set all flip-flops to 0x34 on reset
      ff <= 8'b00110100;
    end else begin
      // On negative edge of clock, load input d into the registers
      ff <= d;
    end
  end

  // Directly assign internal register values to output
  always @(posedge clk) begin
    q <= ff;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
