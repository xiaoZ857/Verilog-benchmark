
module TopModule (
  input clk,
  input reset,
  output shift_ena
);

reg [2:0] counter;
reg shift_ena_reg;

always @(posedge clk) begin
    if (reset) begin
        counter <= 3'd0;
        shift_ena_reg <= 1'b1;
    end else begin
        if (counter < 3'd3) begin
            counter <= counter + 3'd1;
            shift_ena_reg <= 1'b1;
        end else begin
            counter <= counter;
            shift_ena_reg <= 1'b0;
        end
    end
end

assign shift_ena = shift_ena_reg;

endmodule
