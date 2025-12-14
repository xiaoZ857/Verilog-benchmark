
module TopModule (
  input clk,
  input resetn,
  input in,
  output reg [3:0] out
);

always @(posedge clk) begin
  if (!resetn) begin
    out <= 4'b0000; // Reset the shift register to all zeros when resetn is active-low
  end else begin
    out[3] <= in; // Shift the data into the most significant bit (MSB)
    out[0] <= out[1]; // Shift the data to the next lower bits
    out[1] <= out[2];
    out[2] <= out[3];
  end
end

initial begin
  // Optional reset initial block for simulation. Remove it when synthesizing.
  always @* begin
    if (resetn) out <= 4'b0;
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
