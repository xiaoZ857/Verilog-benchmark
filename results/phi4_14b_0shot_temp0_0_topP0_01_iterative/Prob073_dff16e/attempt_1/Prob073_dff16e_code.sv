
module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

  // Internal registers for each bit of the flip-flops
  reg [15:0] ff;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      // Synchronous active-low reset
      ff <= 16'b0;
    end else begin
      // Update only the enabled bytes
      if (byteena[1]) begin
        ff[15:8] <= d[15:8];
      end
      if (byteena[0]) begin
        ff[7:0] <= d[7:0];
      end
    end
  end

  // Output the current state of the flip-flops
  always @(posedge clk) begin
    q <= ff;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
