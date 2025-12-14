
module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);
assign temp_a = (a < b) ? a : b;
assign temp_b = (temp_a < c) ? temp_a : c;
assign temp_c = (temp_b < d) ? temp_b : d;

reg [7:0] local_min = temp_c;  // Declare min as a register for continuous assignment

always @(posedge clk) begin
  if (local_min != temp_c) begin
    local_min <= temp_c;
  end
end

assign min = local_min;  // Assign the value of local_min to the output reg, min

// Add reset and clock inputs as needed:
// input clk, reset;
// always @(posedge reset or posedge clk) begin
//   if (reset) begin
//     local_min <= 8'b0; // Assuming min is initialized to all zeros upon reset
//   end
// end

endmodule
