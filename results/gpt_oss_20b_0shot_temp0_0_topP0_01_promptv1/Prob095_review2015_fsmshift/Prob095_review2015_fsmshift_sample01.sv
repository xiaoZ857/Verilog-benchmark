
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
reg [1:0] cnt;
reg shift_ena_reg;

always @(posedge clk) begin
    if (reset) begin
        cnt <= 2'd0;
        shift_ena_reg <= 1'b1;
    end else begin
        if (cnt < 2'd3) begin
            cnt <= cnt + 1'b1;
            shift_ena_reg <= 1'b1;
        end else begin
            shift_ena_reg <= 1'b0;
        end
    end
end

assign shift_ena

// VERILOG-EVAL: endmodule not found
