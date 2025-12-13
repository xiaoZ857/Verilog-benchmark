
`timescale 1ns / 1ps

module TopModule (
    input  wire clk,     // clock
    input  wire j,       // input that drives OFF → ON transition
    input  wire k,       // input that drives ON  → OFF transition
    input  wire areset,  // active‑high asynchronous reset
    output wire out      // Moore output (0 = OFF, 1 = ON)
);

    /*--------------------------------------------------------------------
     * State encoding
     *--------------------------------------------------------------------*/
    localparam OFF = 1'b0,
               ON  = 1'b1;

    /*--------------------------------------------------------------------
     * Registers
     *--------------------------------------------------------------------*/
    reg state;          // current state
    reg next_state;     // next state (combinational)

    /*--------------------------------------------------------------------
     * Asynchronous reset + state register
     *--------------------------------------------------------------------*/
    always @(posedge clk or posedge areset) begin
        if (areset)          // active‑high asynchronous reset
            state <= OFF;
        else
            state <= next_state;
    end

    /*--------------------------------------------------------------------
     * Next‑state logic (combinational)
     *--------------------------------------------------------------------*/
    always @(*) begin
        case (state)
            OFF: next_state = j;          // OFF --j=0--> OFF, j=1--> ON
            ON:  next_state = ~k;         // ON  --k=0--> ON,  k=1--> OFF
            default: next_state = OFF;    // safety
        endcase
    end

    /*--------------------------------------------------------------------
     * Moore output (output depends only on state)
     *--------------------------------------------------------------------*/
    assign out = state;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
