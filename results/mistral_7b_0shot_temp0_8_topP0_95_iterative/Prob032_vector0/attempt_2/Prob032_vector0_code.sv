
module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o2,
  output o1,
  output o0
);
always @(posedge clk) begin
  outv <= vec; // Assign the same vector to outv

  assign o2 = vec[2]; // Assign the third bit of the input to o2
  assign o1 = vec[1]; // Assign the second bit of the input to o1
  assign o0 = vec[0]; // Assign the first bit of the input to o0
end

// Include clk input and synchronization as needed
reg clk;
input clock;
assign clk = clock; // Connect external clock signal to internal clock signal

endmodule
