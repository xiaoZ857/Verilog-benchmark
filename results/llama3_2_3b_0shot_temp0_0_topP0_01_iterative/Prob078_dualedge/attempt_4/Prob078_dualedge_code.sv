
module TopModule (
  input clk,
  input d,
  output reg q
);

reg [1:0] q_next_r;
reg [1:0] q_next_f;

assign q_next_r[0] = d;
assign q_next_r[1] = q;

reg [1:0] q_prev_r;
reg [1:0] q_prev_f;

always @(posedge clk) begin
    if (q != q_prev_r) begin // check for change in q on rising edge
        q <= q_next_r;
        q_prev_r <= q;
    end
end

always @(negedge clk) begin
    if (q != q_prev_f) begin // check for change in q on falling edge
        q <= q_next_f;
        q_prev_f <= q;
    end
end

assign q_next_f[0] = d;
assign q_next_f[1] = q;

reg [1:0] q_prev_f;

always @(posedge clk) begin
    if (q != q_prev_f) begin // check for change in q on falling edge
        q <= q_next_f;
        q_prev_f <= q;
    end
end

assign q_prev_r = q;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
