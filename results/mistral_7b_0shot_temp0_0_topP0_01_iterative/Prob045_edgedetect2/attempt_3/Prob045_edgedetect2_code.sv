
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);
always @(posedge clk) begin
  for (int i = 0; i < 8; i++) begin
    if ((in[i] && ~prev_in[i]) || (!in[i] && prev_in[i])) begin
      // Store the transition in a temporary variable
      temp_anyedge[i] <= 1'b1;
      // Assign the stored transition to anyedge immediately
      anyedge[i] <= temp_anyedge[i];
    end
    prev_in[i] <= in[i];
  end
end

reg [7:0] prev_in, temp_anyedge;

// Initialize previous input values and temporary anyedge values
always_comb begin
  prev_in = 8'b0;
  temp_anyedge = 8'b0;
end

endmodule
