
`timescale 1ns / 1ps
module TopModule (
    input  wire        clk,   // clock
    input  wire        load,  // active‑high load signal
    input  wire [9:0]  data,  // value to load into the counter
    output wire        tc     // terminal‑count flag (high when counter == 0)
);

    // ------------------------------------------------------------------
    // Internal 10‑bit down‑counter
    // ------------------------------------------------------------------
    reg [9:0] counter;

    // ------------------------------------------------------------------
    // Sequential logic – clock‑synchronous
    // ------------------------------------------------------------------
    always @(posedge clk) begin
        if (load) begin
            // (1) Load the counter with the supplied value
            counter <= data;
        end
        else if (counter != 10'b0) begin
            // (2) Decrement only while the counter is non‑zero
            counter <= counter - 1'b1;
        end
        // If counter == 0 and load == 0, keep it at 0 (stop counting)
    end

    // ------------------------------------------------------------------
    // Combinational output – terminal count flag
    // ------------------------------------------------------------------
    assign tc = (counter == 10'b0);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
