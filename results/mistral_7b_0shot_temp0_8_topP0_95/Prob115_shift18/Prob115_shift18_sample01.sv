
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

always @(posedge clk) begin
  if (load) begin
    q <= data;
  end else if (ena) begin
    switch (amount)
      // left shift by 1 bit
      (2'b00: q <= {q[62], q[63]}; q[63] <= 0; ),
      // left shift by 8 bits
      (2'b01: begin
        for (integer i = 63; i > 7; i--)
          q[i] <= q[i-1];
        q[7] <= 0;
      end),
      // right shift by 1 bit
      (2'b10: begin
        q[63] <= q[62];
        for (integer i = 62; i > 0; i--)
          q[i] <= q[i-1];
      end),
      // right shift by 8 bits
      (2'b11: begin
        for (integer i = 63; i > 7; i--)
          q[i] <= q[i-8];
        for (integer i = 0; i < 8; i++)
          q[i] <= 0;
      end)
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
