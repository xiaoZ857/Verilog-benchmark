
module TopModule (
  input wire clk,
  input wire j,
  input wire k,
  input wire areset,
  output reg out
);

reg state_OFF, state_ON;

always @(posedge clk or negedge areset) begin
    if (areset) begin
        state_OFF <= 0;
        state_ON <= 0;
    end else if (!areset && state_OFF == 1'b1) begin
        state_OFF <= j;
    end else if (state_OFF == 1'b1 && j == 1'b1) begin
        state_ON <= 1'b1;
    end else if (state_ON == 1'b1 && k == 1'b0) begin
        state_ON <= 1'b1;
    end else if (state_ON == 1'b1 && k == 1'b1) begin
        state_OFF <= 1'b0;
    end
end

assign out = state_OFF;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
