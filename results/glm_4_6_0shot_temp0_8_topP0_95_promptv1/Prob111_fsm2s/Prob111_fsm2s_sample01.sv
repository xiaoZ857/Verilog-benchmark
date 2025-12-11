
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

// State encoding
parameter OFF = 1'b0;
parameter ON = 1'b1;

// State register
reg state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
    end else begin
        case (state)
            OFF: begin
                if (j)
                    state <= ON;
                else
                    state <= OFF;
            end
            ON: begin
                if (k)
                    state <= OFF;
                else
                    state <= ON;
            end
        endcase
    end
end

// Output logic
assign out = state;

endmodule
