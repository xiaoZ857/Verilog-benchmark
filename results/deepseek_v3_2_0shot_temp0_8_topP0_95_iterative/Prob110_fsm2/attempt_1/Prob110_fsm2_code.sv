
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
    reg state;
    reg next_state;
    
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;
    
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    assign out = state;
endmodule
