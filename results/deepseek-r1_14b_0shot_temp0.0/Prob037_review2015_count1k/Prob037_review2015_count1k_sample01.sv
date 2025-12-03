

module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end else begin
        if (q != 999) begin
            q <= q + 1;
        end else begin
            q <= 0;
        end
    end
end

// VERILOG-EVAL: endmodule not found
