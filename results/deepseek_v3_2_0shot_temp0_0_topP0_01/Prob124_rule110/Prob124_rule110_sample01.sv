
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  reg [511:0] q_next;
  integer i;
  
  always @(*) begin
    for (i = 0; i < 512; i = i + 1) begin
      // left neighbor = q[i+1] (if exists, else 0)
      // center = q[i]
      // right neighbor = q[i-1] (if exists, else 0)
      case ({i == 511 ? 1'b0 : q[i+1], q[i], i == 0 ? 1'b0 : q[i-1]})
        3'b111: q_next[i] = 1'b0;
        3'b110: q_next[i] = 1'b1;
        3'b101: q_next[i] = 1'b1;
        3'b100: q_next[i] = 1'b0;
        3'b011: q_next[i] = 1'b1;
        3'b010: q_next[i] = 1'b1;
        3'b001: q_next[i] = 1'b1;
        3'b000: q_next[i] = 1'b0;
        default: q_next[i] = 1'b0;
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (load)
      q <= data;
    else
      q <= q_next;
  end
endmodule
