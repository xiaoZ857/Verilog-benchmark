
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);
// Define the internal signals for the multiplexer
reg [11:0][1:0] temp;

// Create a 256-to-1 multiplexer using a loop
for (int i = 0; i < 8; i++) begin : select_loop
  // Select bits in[7:4], in[11:8], etc.
  if (sel[i] == 0) begin
    temp[i*2+3: i*2] <= in[(i*16)+15: (i*16)];
  end else if (sel[i] == 1) begin
    temp[i*2+7: i*2+2] <= in[(i*16)+11: (i*16)+6];
  end else if (sel[i] == 2) begin
    temp[i*2+11: i*2+5] <= in[(i*16)+15: (i*16)+10];
  end else if (sel[i] == 3) begin
    temp[i*2+15: i*2+8] <= in[(i*16)+13: (i*16)+9];
  end else if (sel[i] == 4) begin
    temp[i*2+23: i*2+14] <= in[(i*16)+11: (i*16)+6];
  end else if (sel[i] == 5) begin
    temp[i*2+31: i*2+18] <= in[(i*16)+15: (i*16)+10];
  end else if (sel[i] == 6) begin
    temp[i*2+39: i*2+19] <= in[(i*16)+13: (i*16)+9];
  end else if (sel[i] == 7) begin
    temp[i*2+47: i*2+20] <= in[(i*16)+11: (i*16)+8];
  end
end

// Assign the selected bits to the output signal out
assign out = {temp[0][1], temp[1][1], temp[2][1], temp[3][1]};

// VERILOG-EVAL: endmodule not found
