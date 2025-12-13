
module TopModule (
  input [99:0] in,
  output reg [99:0] out
);
// Use a combinational logic block to reverse the bit ordering
always_comb begin : REVERSE_BIT_ORDERING
    int i;
    for (i = 99; i >= 0; i--) begin
        out[i] = in[99 - i];
    end
end

// Initialize the output signal to zeros on each rising edge of the clock
assign # (posedge clk) out = 0;

// Use a combinational logic block to reverse the bit ordering
always_comb begin : REVERSE_BIT_ORDERING
    int i;
    for (i = 99; i >= 0; i--) begin
        out[i] = in[99 - i];
    end
end

// VERILOG-EVAL: endmodule not found
