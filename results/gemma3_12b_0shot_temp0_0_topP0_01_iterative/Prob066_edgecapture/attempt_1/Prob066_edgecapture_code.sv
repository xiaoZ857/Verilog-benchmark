
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);

  always @(posedge clk) begin
    if (reset) begin
      out <= 0;
    end else begin
      for (int i = 0; i < 32; i++) begin
        if (in[i] == 0 && out[i] == 1) begin
          out[i] <= 1;
        end else begin
          out[i] <= 0;
        end
      end
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
