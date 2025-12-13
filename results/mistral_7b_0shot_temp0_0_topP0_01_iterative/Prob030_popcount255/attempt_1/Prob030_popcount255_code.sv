
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
module PopCount (
  input [254:0] in,
  output reg [7:0] out
);

// Create a 64-bit population counter array
reg [63:0] pop_counts[8];

always @(posedge clk) begin
  // Initialize the population counters to zero
  for (int i = 0; i < 8; i++)
    pop_counts[i] <= 0;

  // Calculate the population count for each 64-bit segment of the input vector
  for (int i = 254; i >= 0; i -= 64) begin
    int j = i / 64;
    int k = i % 64;

    if (k > 0) begin // If there are remaining bits in the current segment
      pop_counts[j] += in[i];
    end

    if (k == 63) begin // If the current segment is full (64 bits)
      pop_counts[j] += pop_counts[j+1];
      pop_counts[j+1] <= 0;
    end
  }

  // Sum up the population counts from each segment to get the final output
  out = 0;
  for (int i = 7; i >= 0; i--) begin
    out[i] += pop_counts[i];
    if (out[i+1] > out[i])
      out[i+1] -= out[i]+1;
  end
end

// Assuming clk is the clock input
assign clk = clk; // Clock input is directly passed through

endmodule
