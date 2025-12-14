
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
      reg [511:0] next_q;
      
      // Leftmost cell (i=0): left = 0, center = q[0], right = q[1]
      case ({1'b0, q[0], q[1]})
        3'b111: next_q[0] = 1'b0;
        3'b110: next_q[0] = 1'b1;
        3'b101: next_q[0] = 1'b1;
        3'b100: next_q[0] = 1'b0;
        3'b011: next_q[0] = 1'b1;
        3'b010: next_q[0] = 1'b1;
        3'b001: next_q[0] = 1'b1;
        3'b000: next_q[0] = 1'b0;
        default: next_q[0] = 1'b0;
      endcase
      
      // Rightmost cell (i=511): left = q[510], center = q[511], right = 0
      case ({q[510], q[511], 1'b0})
        3'b111: next_q[511] = 1'b0;
        3'b110: next_q[511] = 1'b1;
        3'b101: next_q[511] = 1'b1;
        3'b100: next_q[511] = 1'b0;
        3'b011: next_q[511] = 1'b1;
        3'b010: next_q[511] = 1'b1;
        3'b001: next_q[511] = 1'b1;
        3'b000: next_q[511] = 1'b0;
        default: next_q[511] = 1'b0;
      endcase
      
      // Internal cells (i=1 to 510)
      for (integer i = 1; i < 511; i = i + 1) begin
        case ({q[i+1], q[i], q[i-1]})
          3'b111: next_q[i] = 1'b0;
          3'b110: next_q[i] = 1'b1;
          3'b101: next_q[i] = 1'b1;
          3'b100: next_q[i] = 1'b0;
          3'b011: next_q[i] = 1'b1;
          3'b010: next_q[i] = 1'b1;
          3'b001: next_q[i] = 1'b1;
          3'b000: next_q[i] = 1'b0;
          default: next_q[i] = 1'b0;
        endcase
      end
      
      q <= next_q;
    end
  end
endmodule
