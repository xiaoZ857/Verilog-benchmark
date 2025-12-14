
module TopModule (
    input clk,
    input areset,
    input x,
    output z
);

    // State encoding using one-hot encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    reg [1:0] current_state, next_state;

    assign z = (current_state == A) ? (!x) : x; // Mealy output logic

    always @(*) begin
        case(current_state)
            A: begin
                if (areset) 
                    next_state = A;
                else 
                    next_state = (x) ? B : A;
            end
            
            B: begin
                if (areset) 
                    next_state = A;
                else 
                    next_state = B; // Remain in state B regardless of input x
            end
            
            default: 
                next_state = A; // Default to state A on undefined state
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
