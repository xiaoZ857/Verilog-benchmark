
module TopModule (
  input clk,
  input d,
  output reg q
);

// Dual-edge triggered flip-flop implementation
reg [1:0] q_next;

assign q_next[0] = d;
assign q_next[1] = q;

always @(posedge clk) begin
    if (clk == 1'b1) begin // rising edge
        q <= q_next;
    end else if (clk == 1'b0) begin // falling edge
        q <= q_next;
    end
end

assign q = q_next;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
