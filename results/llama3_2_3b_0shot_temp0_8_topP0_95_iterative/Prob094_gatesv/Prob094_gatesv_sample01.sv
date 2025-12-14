
module TopModule (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);
// Initialize output vectors to '0's
assign out_both = 0;
assign out_any[1:3] = 0; // Corrected index range for out_any
assign out_different[3:0] = 0;

// Calculate out_both
always @(posedge clk) begin
    // Since in[0] has no neighbour to the left, we directly assign
    out_both[0] = in[1]; 
    out_both[1] = in[2];
    out_both[2] = in[3];
end

// Calculate out_any
always @(posedge clk) begin
    // For out_any, since in[0] has no neighbour to the right,
    // we directly assign the left neighbour for each bit.
    out_any[1] = in[0];  // Corrected calculation to include only necessary neighbours
    out_any[2] = in[1];
    out_any[3] = in[2];
end

// Calculate out_different
always @(posedge clk) begin
    // Treat the vector as wrapping around for the right neighbour.
    out_different[0] = in[0] ^ in[4]; // Corrected index to include wrapping case
    out_different[1] = in[1] ^ in[2];
    out_different[2] = in[2] ^ in[3]; 
    out_different[3] = in[3] ^ in[0];  // Wrapped around for calculation and correct indexing
end

endmodule
