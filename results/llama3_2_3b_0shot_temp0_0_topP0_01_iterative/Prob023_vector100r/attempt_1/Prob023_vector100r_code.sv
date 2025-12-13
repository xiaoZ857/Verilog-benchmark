
// Implement the Verilog module based on the following description.
// Given a 100-bit input vector [99:0], reverse its bit ordering.

module TopModule (
  input [99:0] in,
  output reg [99:0] out
);

// Initialize the output signal to zeros
assign out = 0;

// Use a combinational logic block to reverse the bit ordering
always_comb begin : REVERSE_BIT_ORDERING
    int i;
    for (i = 99; i >= 0; i--) begin
        out[i] = in[99 - i];
    end
end

// Initialize the output signal to zeros
assign # (posedge clk) out = 0;

// Use a combinational logic block to reverse the bit ordering
always_comb begin : REVERSE_BIT_ORDERING
    int i;
    for (i = 99; i >= 0; i--) begin
        out[i] = in[99 - i];
    end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
