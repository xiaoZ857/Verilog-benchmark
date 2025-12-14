
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
    reg state, next_state;
    localparam A = 1'b0;  // Haven't seen first '1' yet
    localparam B = 1'b1;  // Have seen first '1'
    
    // State register with asynchronous reset
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
    
    // Output logic - Moore style
    assign z = (state == A) ? x : ~x;
endmodule
