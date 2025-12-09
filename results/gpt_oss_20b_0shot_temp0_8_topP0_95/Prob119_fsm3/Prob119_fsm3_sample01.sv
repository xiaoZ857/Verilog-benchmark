
//  Moore FSM – 4 states (A,B,C,D)
//  Asynchronous positive‑edge reset → state A
//  Output is determined only by the current state

module TopModule (
    input  wire clk,    // synchronous clock
    input  wire in,     // single input
    input  wire areset, // asynchronous reset
    output wire out     // FSM output
);

    /*--------------------------------------------------------------------
      State encoding
      --------------------------------------------------------------------*/
    localparam  A = 2'b00,
                B = 2'b01,
                C = 2'b10,
                D = 2'b11;

    /*--------------------------------------------------------------------
      State register
      --------------------------------------------------------------------*/
    reg  [1:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)                // asynchronous reset
            state <= A;
        else
            state <= next_state;   // synchronous state update
    end

    /*--------------------------------------------------------------------
      Next‑state logic
      --------------------------------------------------------------------*/
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;   // safety net
        endcase
    end

    /*--------------------------------------------------------------------
      Output logic – Moore (output depends only on the current state)
      --------------------------------------------------------------------*/
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
