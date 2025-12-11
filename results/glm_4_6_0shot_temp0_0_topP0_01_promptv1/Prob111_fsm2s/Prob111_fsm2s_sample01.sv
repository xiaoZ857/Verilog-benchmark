
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

parameter OFF = 1'b0;
parameter ON = 1'b1;

reg current_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= OFF;
    end else begin
        case (current_state)
            OFF: begin
                if (j) begin
                    current_state <= ON;
                end else begin
                    current_state <= OFF;
                end
            end
            ON: begin
                if (k) begin
                    current_state <= OFF;
                end else begin
                    current_state <= ON;
                end
            end
        endcase
    end
end

assign out = current_state;

endmodule
