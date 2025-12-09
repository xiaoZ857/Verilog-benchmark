

module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

always @(posedge clk) begin
    for (int i = 0; i < 8; i++) begin
        if (in[i] && !prev_in[i]) begin
            pedge[i] <= 1'b1;
        end
        prev_in[i] <= in[i];
    end
end

reg [7:0] prev_in; // Initialize previous input values

// VERILOG-EVAL: endmodule not found
