
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
  reg [1:0] count;
  reg ena_reg;
  
  always @(posedge clk) begin
    if (reset) begin
      count <= 2'b00;
      ena_reg <= 1'b1;
    end else begin
      if (ena_reg) begin
        if (count == 2'b11) begin
          ena_reg <= 1'b0;
        end else begin
          count <= count + 1;
        end
      end
    end
  end
  
  assign shift_ena = ena_reg;
endmodule
