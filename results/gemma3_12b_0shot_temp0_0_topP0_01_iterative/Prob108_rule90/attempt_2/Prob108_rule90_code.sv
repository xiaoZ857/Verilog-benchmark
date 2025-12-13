
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  reg [511:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end

  always @(*) begin
    for (int i = 0; i < 512; i++) begin
      // Determine neighbors.  Handle boundary conditions.
      // q[-1] = 0, q[512] = 0
      
      // Calculate XOR of neighbors
      if (i == 0) begin
        next_q[i] = q[i] ^ 0 ^ q[i+1];
      end else if (i == 511) begin
        next_q[i] = q[i] ^ q[i-1] ^ 0;
      end else begin
        next_q[i] = q[i-1] ^ q[i] ^ q[i+1];
      end
    end
  end

// VERILOG-EVAL: endmodule not found
