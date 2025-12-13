
module TopModule (
  input clk,
  input d,
  output reg q
);

// Dual-edge triggered flip-flop implementation
reg [1:0] q_next;

assign q_next[0] = d;
assign q_next[1] = q;

always @(posedge clk or negedge clk) begin
    if (q_next != q) begin // check for change in q
        q <= q_next;
    end
end

assign q = q_next;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
