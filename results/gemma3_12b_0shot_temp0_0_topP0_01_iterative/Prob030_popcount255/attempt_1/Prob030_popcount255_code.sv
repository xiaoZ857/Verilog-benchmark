
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);

  // Use a ripple-carry population count.  This is simple to implement
  // but not the most efficient.  For a 255-bit input, a more
  // efficient implementation (e.g., using tree-based reduction)
  // would be preferable for performance.

  wire [254:0] carry_out;

  // First stage:  Each bit contributes to a carry if it's 1.
  assign carry_out[0] = in[0];
  genvar i;
  generate
    for (i = 1; i < 255; i = i + 1) begin: ripple_carry_stage
      assign carry_out[i] = in[i] ^ carry_out[i-1];
    end
  endgenerate

  // Second stage:  Sum the carries to get the population count.
  reg [7:0] sum;

  always @(posedge clk) begin
    sum[0] <= carry_out[0];
    for (i = 1; i < 255; i = i + 1) begin
      sum[0] <= sum[0] + carry_out[i];
    end
    
    sum[1] <= carry_out[1];
    for (i = 2; i < 255; i = i + 1) begin
      sum[1] <= sum[1] + carry_out[i];
    end
    
    sum[2] <= carry_out[2];
    for (i = 3; i < 255; i = i + 1) begin
      sum[2] <= sum[2] + carry_out[i];
    end
    
    sum[3] <= carry_out[3];
    for (i = 4; i < 255; i = i + 1) begin
      sum[3] <= sum[3] + carry_out[i];
    end
    
    sum[4] <= carry_out[4];
    for (i = 5; i < 255; i = i + 1) begin
      sum[4] <= sum[4] + carry_out[i];
    end
    
    sum[5] <= carry_out[5];
    for (i = 6; i < 255; i = i + 1) begin
      sum[5] <= sum[5] + carry_out[i];
    end
    
    sum[6] <= carry_out[6];
    for (i = 7; i < 255; i = i + 1) begin
      sum[6] <= sum[6] + carry_out[i];
    end
    
    sum[7] <= carry_out[7];
    for (i = 8; i < 255; i = i + 1) begin
      sum[7] <= sum[7] + carry_out[i];
    end
  end

  assign out = sum;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
