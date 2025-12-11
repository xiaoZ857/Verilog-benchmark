
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
reg [99:0] internal_q;

always @(posedge clk) begin
    if (load)
        internal_q <= data;
    else
        case (ena)
            2'b01: internal_q <= {internal_q[98:0], internal_q[99]};
            2'b10: internal_q <= {internal_q[0], internal_q[99:1]};
            default: internal_q <= internal_q;
        endcase
end

assign q = internal_q;

endmodule
