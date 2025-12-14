
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
  reg [31:0] temp_out;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out <= 0;
    end else begin
      for (int i = 0; i < 32; i++) begin
        if (in[i] == 0 && temp_out[i] == 1) begin
          temp_out[i] <= 1;
        end else begin
          temp_out[i] <= in[i];
        end
      end
      out <= temp_out;
    end
  end
endmodule
