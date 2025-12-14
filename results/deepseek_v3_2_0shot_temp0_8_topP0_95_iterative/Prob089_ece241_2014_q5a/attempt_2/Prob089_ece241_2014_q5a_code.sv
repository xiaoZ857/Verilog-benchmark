
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
    reg state, next_state;
    localparam A = 1'b0, B = 1'b1;
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    assign z = (state == A) ? x : ~x;
endmodule
