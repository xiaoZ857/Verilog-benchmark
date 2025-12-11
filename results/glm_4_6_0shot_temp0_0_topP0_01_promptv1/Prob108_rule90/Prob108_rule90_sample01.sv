
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else begin
    // Calculate next state for each cell using Rule 90
    // next_state[i] = left_neighbor XOR right_neighbor
    // Boundaries are 0
    q[0] <= 1'b0 ^ q[1];
    q[511] <= q[510] ^ 1'b0;
    
    // Calculate for middle cells
    for (integer i = 1; i < 511; i = i + 1) begin
      q[i] <= q[i-1] ^ q[i+1];
    end
  end
end
endmodule
