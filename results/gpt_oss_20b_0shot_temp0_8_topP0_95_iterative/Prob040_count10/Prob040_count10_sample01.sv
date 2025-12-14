
// ---------------------------------------------------------------------------
//  TopModule : 4‑bit synchronous decade counter
// ---------------------------------------------------------------------------
//  Description
//  -----------
//  Counts from 0 to 9 (inclusive).  The counter is synchronous – it
//  advances on the rising edge of clk.  A high reset synchronously
//  brings the counter back to 0.  The output `q` is a 4‑bit register
//  that holds the current count value.
//
//  Implementation notes
//  --------------------
//  * The counter is reset only on the *clock edge* when reset is asserted
//    – this is the definition of a *synchronous* reset.
//  * The counter rolls over to 0 after 9.  We explicitly test for 9
//    instead of relying on the 4‑bit overflow because the counter
//    should never reach 10 (binary 1010).
//
//  Interface
//  ---------
//  input  clk      – rising‑edge clock
//  input  reset    – active‑high synchronous reset
//  output reg [3:0] q   – current count (0 … 9)
// ---------------------------------------------------------------------------

module TopModule (
    input  wire        clk,
    input  wire        reset,
    output reg  [3:0]  q
);

    // Sequential logic – synchronous reset and counting
    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset: set counter to 0
            q <= 4'd0;
        end else if (q == 4'd9) begin
            // When 9 is reached, wrap back to 0
            q <= 4'd0;
        end else begin
            // Normal count increment
            q <= q + 1'b1;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
