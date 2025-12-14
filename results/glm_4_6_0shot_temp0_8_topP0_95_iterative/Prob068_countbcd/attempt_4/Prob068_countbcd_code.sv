
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

always @(posedge clk) begin
  if (reset) begin
    q <= 16'd0;
  end else begin
    // BCD counter logic
    if (q[3:0] == 4'd9) begin
      q[3:0] <= 4'd0;
      if (q[7:4] == 4'd9) begin
        q[7:4] <= 4'd0;
        if (q[11:8] == 4'd9) begin
          q[11:8] <= 4'd0;
          if (q[15:12] == 4'd9) begin
            q[15:12] <= 4'd0;
          end else begin
            q[15:12] <= q[15:12] + 1;
          end
        end else begin
          q[11:8] <= q[11:8] + 1;
        end
      end else begin
        q[7:4] <= q[7:4] + 1;
      end
    end else begin
      q[3:0] <= q[3:0] + 1;
    end
  end
end

// Enable signals for upper digits
assign ena[1] = (q[

// VERILOG-EVAL: endmodule not found
