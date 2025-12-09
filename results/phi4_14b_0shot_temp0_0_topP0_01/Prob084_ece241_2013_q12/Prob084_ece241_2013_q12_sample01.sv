

module TopModule (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);

  wire [7:0] Q;
  
  // 8-bit shift register using D flip-flops
  always @(posedge clk) begin
    if (enable) begin
      Q[7] <= S;          // MSB is shifted in first
      Q[6] <= Q[7];
      Q[5] <= Q[6];
      Q[4] <= Q[5];
      Q[3] <= Q[4];
      Q[2] <= Q[3];
      Q[1] <= Q[2];
      Q[0] <= Q[1];
    end
  end

  // Multiplexer to select the output based on inputs A, B, C
  always @(*) begin
    case ({A, B, C})
      3'b000: Z = Q[0];
      3'b001: Z = Q[1];
      3'b010: Z = Q[2];
      3'b011: Z = Q[3];
      3'b100: Z = Q[4];
      3'b101: Z = Q[5];
      3'b110: Z = Q[6];
      3'b111: Z = Q[7];
      default: Z = 1'bx; // Undefined state
    endcase
  end

endmodule
