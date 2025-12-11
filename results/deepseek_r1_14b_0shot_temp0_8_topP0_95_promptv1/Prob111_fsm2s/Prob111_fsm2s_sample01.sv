
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
always @(posedge clk) begin
    if (reset)
        current_state <= 0;
    else begin
        case (current_state)
            0: 
                if (j == 1)
                    next_state = 1;
                else
                    next_state = 0;
            1:
                if (k == 1)
                    next_state = 0;
                else
                    next_state = 1;
        endcase
        current_state <= next_state;
    end
end

assign out = current_state;

endmodule
