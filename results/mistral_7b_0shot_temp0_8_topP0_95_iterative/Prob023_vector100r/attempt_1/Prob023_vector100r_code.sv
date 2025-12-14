
module TopModule (
  input [99:0] in,
  output reg [99:0] out
);

always @(posedge clk) begin
    for (int i = 99; i >= 0; i--) begin
        out[i] <= in[99-i];
    end
end

// If you want to add a reset signal to reset the output vector to all zeros:
reg [99:0] reset_out = 0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= reset_out;
    end
end

// Add a reset signal input and connect it to the desired reset source.
input reset;

// Connect in with your actual input vector.
assign in = your_input_vector;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
