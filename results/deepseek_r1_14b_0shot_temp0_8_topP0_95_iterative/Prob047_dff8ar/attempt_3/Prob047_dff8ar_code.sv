
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 0;
    end else begin
        case (1)
            0: q[0] <= d[0];
            1: q[1] <= d[1];
            2: q[2] <= d[2];
            3: q[3] <= d[3];
            4: q[4] <= d[4];
            5: q[5] <= d[5];
            6: q[6] <= d[6];
            7: q[7] <= d[7];
        endcase
    end
end

endmodule
