

module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

reg [7:0] pedge;

always @(posedge clk) begin
  for (int i = 0; i < 8; i++) begin
    if ((in[i] == 1'b0) && (i == 0 || in[i-1] == 1'b1)) begin
      pedge[i] <= 1;
    end else if ((in[i] == 1'b1) && (i < 7 || in[i+1] == 1'b0)) begin
      pedge[i] <= 1;
    end else begin
      pedge[i] <= 0;
    end
  end
end

assign pedge[7] = pedge[6];

// VERILOG-EVAL: endmodule not found
