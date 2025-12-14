
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
always @(posedge clk or posedge resetn) begin
  if (!resetn)
    out <= 4'b0; // Reset the shift register to all zeros when resetn is active-low
  else begin
    out[3] <= in; // Shift the data into the most significant bit (MSB)
    out[0:2] <= out[1:4]; // Shift the data to the next lower bits
  end
end

initial begin
  // Optional reset initial block for simulation. Remove it when synthesizing.
  always @* begin
    if (resetn) out <= 4'b0;
  end
end

endmodule
