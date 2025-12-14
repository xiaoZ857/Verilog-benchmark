
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
logic [7:0] flip_flops [7:0]; // Declare an array of flip-flops instead of a single module instance

generate
for (integer i = 0; i < 8; i = i + 1) begin : DFF_instances
  assign flip_flops[i].CLK(clk);  // Assign clk to each flip-flop's clock input
  assign flip_flops[i].RESET(areset);  // Assign areset to each flip-flop's reset input
  assign flip_flops[i].D(d[i]);     // Assign d[i] to each flip-flop's D input
  assign flip_flops[i].Q(q[i]);    // Assign q[i] to each flip-flop's Q output
end

initial begin
  // Initialize all flip-flops to 0 when reset is high (active high)
  always @(posedge areset)
    for (integer i = 0; i < 8; i = i + 1)
      q[i] <= 1'b0;
end

always @(posedge clk)
begin
  // Assign the D value to each flip-flop on the rising edge of clk
  for (integer i = 0; i < 8; i = i + 1)
    q[i] <= d[i];
end

endmodule
