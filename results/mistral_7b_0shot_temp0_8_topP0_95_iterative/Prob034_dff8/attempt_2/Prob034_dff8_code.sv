
module TopModule (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);
always @(posedge clk) begin
  q <= dff_regs; // Assign new input data to output q after updating DFF registers
end

assign q[0] = d[0]; // Assign the first bit of input data directly to q[0] as there is no DFF for this bit

always @(posedge clk) begin
  dff_regs <= {dff_regs[1], d[1], q[1]}; // Update the register array starting from the second DFF
end

always @(posedge clk) begin
  dff_regs <= {dff_regs[2], d[2], q[2]};
end

... (Repeat this always block for each bit up to q[7])

assign q[7] = dff_regs[7]; // Assign the last bit of DFF register array to output q[7]

endmodule
