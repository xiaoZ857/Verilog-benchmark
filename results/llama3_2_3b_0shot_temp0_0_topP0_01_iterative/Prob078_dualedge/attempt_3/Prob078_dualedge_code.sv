
module TopModule (
  input clk,
  input d,
  output reg q
);

reg [1:0] q_next;
reg [1:0] q_prev;

assign q_next[0] = d;
assign q_next[1] = q;

always @(posedge clk) begin
    if (q != q_prev) begin // check for change in q
        q <= q_next;
    end
end

always @(negedge clk) begin
    if (q != q_prev) begin // check for change in q
        q <= q_next;
    end
end

assign q_prev = q;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
