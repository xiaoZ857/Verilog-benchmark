
module TopModule (
  input wire clk,
  input wire resetn,
  input wire [1:0] byteena, // Controls which byte to update: byteena[1] for upper, byteena[0] for lower
  input wire [15:0] d,     // Data input
  output reg [15:0] q      // Data output
);

  reg [7:0] q_lower;       // Lower byte of the register
  reg [7:0] q_upper;       // Upper byte of the register

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      // Synchronous active-low reset
      q_lower <= 8'b0;
      q_upper <= 8'b0;
    end else begin
      // Update lower byte based on byteena[0]
      if (byteena[0]) begin
        q_lower <= d[7:0];
      end
      
      // Update upper byte based on byteena[1]
      if (byteena[1]) begin
        q_upper <= d[15:8];
      end
    end
  end

  always @(*) begin
    // Assign the combined bytes to the output register
    q = {q_upper, q_lower};
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
