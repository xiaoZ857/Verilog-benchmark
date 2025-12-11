
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
always @(posedge clk or areset) begin
    if (areset)
        q <= 4'b0;
    else begin
        if (load)
            q <= data;
        else if (ena) begin
            q[3] <= 1'b0;
            q[2:0] <= q[1:0];
        end
    end
end
endmodule
