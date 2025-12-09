

module TopModule (
  input [254:0] in,
  output reg [7:0] out
);

module PopCount (
  input [254:0] data,
  output reg [7:0] pop_count
);

reg [254:0] prev_data = 8'bz; // Initialize previous data to zero
always @(posedge clk) begin
  prev_data <= data;
end

always @(posedge clk) begin
  pop_count <= 8'b0;
  for (int i = 254; i >= 0; i--) begin
    if (prev_data[i] ^ data[i]) begin
      pop_count[7-i/32] += (1'b1 << (i%32)); // Add the contribution of the current bit to the appropriate position in pop_count
    end
  end
end

endmodule
