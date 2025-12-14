
module TopModule (
  input [31:0] in,
  output [31:0] out
);
module ByteSwap32 (
  input [31:0] in,
  output [31:0] out
);

// Fix the timescale directive placement error
`timescale ins/ns /ns

always @(posedge clk)
begin
  out = {in[31:24], in[23:16], in[15:8], in[7:0]};
end

// Optional reset signal (assuming active-low)
reg [31:0] temp;
input reset;
always @(posedge clk or negedge reset)
begin
  if (!reset)
    temp <= in;
end

// Add this part if you want to use the temp register for easier testing/simulation.
assign out = temp;

// Include endmodule statement
endmodule
