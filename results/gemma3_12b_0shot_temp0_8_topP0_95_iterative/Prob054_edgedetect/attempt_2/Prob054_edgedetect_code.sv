
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
  reg [7:0] prev_in;

  always @(posedge clk) begin
    pedge = 0; // Initialize pedge to 0 at the beginning of each clock cycle
    for (int i = 0; i < 8; i++) begin
      if (in[i] == 1 && prev_in[i] == 0) begin
        pedge[i] = 1;
      else begin
        pedge[i] = 0;
      end
    end
    prev_in = in;
  end

// VERILOG-EVAL: endmodule not found
