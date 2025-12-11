
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
always @(posedge clk or areset) begin
    if (areset)
        current_state <= 2'b00;
    else
        case (current_state)
            2'b00: 
                if (j == 1)
                    next_state = 2'b01;
                else 
                    next_state = 2'b00;
            2'b01:
                if (k == 1)
                    next_state = 2'b00;
                else 
                    next_state = 2'b01;
            default: 
                next_state = 2'b00; // Default to OFF state
        endcase
    current_state <= next_state;
end

assign out = current_state ? 1 : 0;

endmodule
