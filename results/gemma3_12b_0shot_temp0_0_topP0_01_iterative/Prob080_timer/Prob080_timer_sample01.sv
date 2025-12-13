
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
  reg [9:0] counter;
  reg tc_reg;

  always @(posedge clk) begin
    if (load) begin
      counter <= data;
      tc_reg <= 0; // Reset tc when loading
    end else if (counter > 0) begin
      counter <= counter - 1;
      tc_reg <= 0;
    end else begin
      counter <= 0; // Ensure counter stays at 0 after terminal count
      tc_reg <= 1; // Assert tc when counter reaches 0
    end
  end

  assign tc = tc_reg;

endmodule
