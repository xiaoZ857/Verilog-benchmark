
module TopModule (
  input clk,
  input x,
  output z
);

reg [2:0] ff; // Three D flip-flops
wire xor_out, and_out, or_out;
wire ff0_out, ff1_out, ff2_out;
wire ff0_out_n, ff1_out_n, ff2_out_n;

// Assign flip-flop outputs
assign ff0_out = ff[0];
assign ff1_out = ff[1];
assign ff2_out = ff[2];

// Complemented outputs
assign ff0_out_n = ~ff[0];
assign ff1_out_n = ~ff[1];
assign ff2_out_n = ~ff[2];

// Gate outputs
assign xor_out = x ^ ff0_out;
assign and_out = x & ff1_out_n;
assign or_out = x | ff2_out_n;

// Three-input NOR gate
assign z = ~(ff0_out | ff1_out | ff2_out);

// D flip-flops with synchronous reset
always @(posedge clk) begin
  ff[0] <= xor_out;
  ff[1] <= and_out;
  ff[2] <= or_out;
end

endmodule
