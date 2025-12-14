
module TopModule (
    input  wire clk,    // clock
    input  wire j,      // input that drives transition from OFF → ON
    input  wire k,      // input that drives transition from ON  → OFF
    input  wire reset,  // active‑high synchronous reset
    output reg  out     // output (Moore, depends only on the state)
);

    /*--------------------------------------------------------------------
     *  State encoding
     *--------------------------------------------------------------------*/
    localparam OFF = 1'b0;   // state OFF   → out = 0
    localparam ON  = 1'b1;   // state ON    → out = 1

    reg state;              // current state

    /*--------------------------------------------------------------------
     *  State transition – synchronous logic
     *--------------------------------------------------------------------*/
    always @(posedge clk) begin
        if (reset) begin
            // synchronous reset to OFF
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    // OFF → OFF if j==0, OFF → ON if j==1
                    state <= j ? ON : OFF;
                end
                ON: begin
                    // ON  → ON if k==0, ON  → OFF if k==1
                    state <= k ? OFF : ON;
                end
                default: begin
                    // safety: return to OFF on illegal state
                    state <= OFF;
                end
            endcase
        end
    end

    /*--------------------------------------------------------------------
     *  Output logic – Moore (output follows state)
     *--------------------------------------------------------------------*/
    always @(posedge clk)

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
