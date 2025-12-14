
module TopModule (
  input [4:1] x,
  output logic f
);
assign f = ~(x[1] & x[2]) | (x[3] & x[4]);

// To handle edge-triggered inputs correctly, use always_comb block
always_comb begin
  assign f = ~(x[1] & x[2]) | (x[3] & x[4]);
end

// Add a register for clock-triggered output f
reg [31:0] q_f;

assign #1 q_f = f;
assign f = q_f;

endmodule
