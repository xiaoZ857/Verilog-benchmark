
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
reg state_OFF, state_ON;

// Timescale directive should be outside the module definition
`timescale 1ns / 1ps

always @(posedge clk or negedge areset) begin
    if (areset) begin
        state_OFF <= 0;
        state_ON <= 0;
    end else if (state_OFF == 1'b1 && j == 1'b1) begin
        state_ON <= 1'b1;
    end else if (state_ON == 1'b1) begin
        if (k == 1'b0) begin
            state_ON <= 1'b1;
        end else begin
            state_OFF <= 1'b0;
            state_ON <= 1'b0;
        end
    end else if (state_OFF == 1'b0) begin
        state_OFF <= j;
    end
end

assign out = state_OFF;

endmodule
