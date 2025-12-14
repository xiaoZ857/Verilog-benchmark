
module TopModule (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output reg [53:0] concatenated_input,
  output reg [7:0] w,
  output reg [7:0] x,
  output reg [7:0] y,
  output reg [7:0] z
);

always @(posedge clk) begin
  concatenated_input <= {a, b, c, d, e, f, 1'b1, 1'b1};
end

assign w = concatenated_input[30:24];
assign x = concatenated_input[23:16];
assign y = concatenated_input[15:8];
assign z = concatenated_input[7:0];

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
