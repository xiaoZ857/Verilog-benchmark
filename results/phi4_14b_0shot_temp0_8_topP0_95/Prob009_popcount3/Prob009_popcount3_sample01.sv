
module TopModule (
  input [2:0] in,
  output reg [1:0] out
);

  always @(*) begin
    // Initialize output to 0
    out = 2'b00;
    
    // Count the number of '1's in the input vector
    if (in[2]) out = out + 2'b01; // Check the most significant bit
    if (in[1]) out = out + 2'b01; // Middle bit
    if (in[0]) out = out + 2'b01; // Least significant bit
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
