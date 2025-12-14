
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);
always @(posedge clk) begin
  for (int i = 0; i < 8; i++) begin
    if ((in[i] && !prev_in[i]) || (!in[i] && prev_in[i])) begin
      anyedge_next[i] <= 1'b1;
    end
    prev_in[i] <= in[i];
  end
end

always @(posedge clk) begin
  anyedge <= anyedge_next;
end

reg [7:0] anyedge_next, prev_in;

// VERILOG-EVAL: endmodule not found
