
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
  // Fix: Declare stage1 as a 1D array with packed dimensions
  wire [7:0] stage1 [0:31];
  wire [7:0] stage2 [0:15];
  wire [7:0] stage3 [0:7];
  wire [7:0] stage4 [0:3];
  wire [7:0] stage5 [0:1];
  wire [7:0] stage6;

  // Stage 1: 32 groups of 8 bits each (256 bits total, but we have 255 bits)
  // We'll handle the last group separately.
  genvar i;
  generate
    for (i = 0; i < 31; i = i + 1) begin : stage1_gen
      assign stage1[i] = {7'b0, in[i*8+0]} + {7'b0, in[i*8+1]} +
                         {7'b0, in[i*8+2]} + {7'b0, in[i*8+3]} +
                         {7'b0, in[i*8+4]} + {7'b0, in[i*8+5]} +
                         {7'b0, in[i*8+6]} + {7'b0, in[i*8+7]};
    end
  endgenerate
  // Last group (bits 248 to 254) = 7 bits
  assign stage1[31] = {7'b0, in[248]} + {7'b0, in[249]} +
                      {7'b0, in[250]} + {7'b0, in[251]} +
                      {7'b0, in[252]} + {7'b0, in[253]} +
                      {7'b0, in[254]};

  // Stage 2: 16 groups of 2 sums each
  generate
    for (i = 0; i < 16; i = i + 1) begin : stage2_gen
      assign stage2[i] = stage1[i*2] + stage1[i*2+1];
    end
  endgenerate

  // Stage 3: 8 groups of 2 sums each
  generate
    for (i = 0; i < 8; i = i + 1) begin : stage3_gen
      assign stage3[i] = stage2[i*2] + stage2[i*2+1];
    end
  endgenerate

  // Stage 4: 4 groups of 2 sums each
  generate
    for (i = 0; i < 4; i = i + 1) begin : stage4_gen
      assign stage4[i] = stage3[i*2] + stage3[i*2+1];
    end
  endgenerate

  // Stage 5: 2 groups of 2 sums each
  generate
    for (i = 0; i < 2; i = i + 1) begin : stage5_gen
      assign stage5[i] = stage4[i*2] + stage4[i*2+1];
    end
  endgenerate

  // Stage 6: final sum
  assign stage6 = stage5[0] + stage5[1];

  always @(*) begin
    out = stage6;
  end
endmodule
