
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);

  always @(*) begin
    // Default to zero if there's no '1' bit in the input vector
    pos = 3'b000;
    
    // Check each bit starting from the least significant bit (LSB)
    if (in[0]) begin
      pos = 3'b000; // Bit position is 0
    end else if (in[1]) begin
      pos = 3'b001; // Bit position is 1
    end else if (in[2]) begin
      pos = 3'b010; // Bit position is 2
    end else if (in[3]) begin
      pos = 3'b011; // Bit position is 3
    end else if (in[4]) begin
      pos = 3'b100; // Bit position is 4
    end else if (in[5]) begin
      pos = 3'b101; // Bit position is 5
    end else if (in[6]) begin
      pos = 3'b110; // Bit position is 6
    end else if (in[7]) begin
      pos = 3'b111; // Bit position is 7
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
