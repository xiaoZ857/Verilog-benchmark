

module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

reg [3:0] q;

always @(posedge clk) begin
    if (areset) begin
        q <= 4'd0;
    end else if (load && !ena) begin
        q <= data;
    end else if (ena) begin
        q <= {q[1:0], q[2]};
    end
end

assign q[3] = 4'd0;

endmodule
