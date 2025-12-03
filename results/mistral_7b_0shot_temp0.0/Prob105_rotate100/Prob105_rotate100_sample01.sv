

module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else if (ena[1]) begin
        q <= {q[98], q[0]}; // right rotation
    end else if (ena[0]) begin
        q <= {q[1], q[99]}; // left rotation
    end
end

assign q_out = q[99]; // output the most significant bit

endmodule
