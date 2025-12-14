
// TopModule.v
// Recognizes 8‑bit keyboard scancodes for keys 0–9.
//  - out  : 4‑bit key value (0…9)
//  - valid: 1 when a known key is detected, 0 otherwise
//
// Assumptions
//  * All signals are positive‑edge triggered except those explicitly combinational.
//  * The module is purely combinational – no clock is needed.

`timescale 1ns / 1ps

module TopModule (
    input  wire [7:0] code,   // 8‑bit keyboard scancode
    output reg  [3:0] out,    // decoded key (0‑9)
    output reg        valid   // 1‑bit flag indicating a match
);

    // Combinational logic
    always @(*) begin
        // Default values (no match)
        out   = 4'd0;
        valid = 1'b0;

        // Recognize each scancode
        case (code)
            8'h45: begin out = 4'd0; valid = 1'b1; end
            8'h16: begin out = 4'd1; valid = 1'b1; end
            8'h1e: begin out = 4'd2; valid = 1'b1; end
            8'h26: begin out = 4'd3; valid = 1'b1; end
            8'h25: begin out = 4'd4; valid = 1'b1; end
            8'h2e: begin out = 4'd5; valid = 1'b1; end
            8'h36: begin out = 4'd6; valid = 1'b1; end
            8'h3d: begin out = 4'd7; valid = 1'b1; end
            8'h3e: begin out = 4'd8; valid = 1'b1; end
            8'h46: begin out = 4'd9; valid = 1'b1; end
            // No other cases – default already handles them
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
