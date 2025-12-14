
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 32'h1; // Synchronous reset sets `q` to 32'h1
    end else begin
        // Calculate the new bit for feedback using XOR on tap positions with q[0]
        wire new_bit = q[31] ^ q[21] ^ q[1] ^ q[0];
        
        // Shift right and insert the new bit at MSB position
        q <= {new_bit, q[31:1]};
    end
end

endmodule
