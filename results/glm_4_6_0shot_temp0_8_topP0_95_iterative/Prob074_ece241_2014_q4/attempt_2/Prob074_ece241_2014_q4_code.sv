
module TopModule (
  input clk,
  input x,
  output z
);
reg [2:0] ff_state;
wire [2:0] ff_next;
wire ff1_out, ff2_out, ff3_out;

assign ff1_out = ff_state[0];
assign ff2_out = ff_state[1];
assign ff3_out = ff_state[2];

// Compute next states
assign ff_next[0] = x ^ ff1_out;  // XOR gate
assign ff_next[1] = x & ~ff2_out; // AND gate with complemented feedback
assign ff_next[2] = x | ~ff3_out; // OR gate with complemented feedback

// Three-input NOR gate for output z
assign z = ~(ff1_out | ff2_out | ff3_out);

// D flip-flops with reset to zero
always @(posedge clk) begin
  ff_state <= ff_next;
end

// Initialize to zero
initial begin
  ff_state = 3'b000;
end
endmodule
