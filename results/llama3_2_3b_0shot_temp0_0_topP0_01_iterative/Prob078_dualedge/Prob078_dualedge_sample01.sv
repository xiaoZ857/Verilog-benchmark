
module TopModule (
  input clk,
  input d,
  output reg q
);

reg [1:0] q_next_r;
reg [1:0] q_prev_r;

always @(posedge clk) begin
    if (q != q_prev_r[0]) begin // check for change in q on rising edge
        q <= q_next_r;
        q_prev_r[0] <= d;
    end
end

always @(negedge clk) begin
    if (q != q_prev_r[1]) begin // check for change in q on falling edge
        q <= q_next_r;
        q_prev_r[1] <= d;
    end
end

assign q_next_r[0] = q;
assign q_next_r[1] = q;

reg [1:0] q_prev_r;

always @(posedge clk) begin
    if (q != q_prev_r[0]) begin // check for change in q on rising edge
        q_prev_r[0] <= q;
    end
end

always @(negedge clk) begin
    if (q != q_prev_r[1]) begin // check for change in q on falling edge
        q_prev_r[1] <= q;
    end
end

assign q_prev_r = {q_prev_r[0], q_prev_r[1]};

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
