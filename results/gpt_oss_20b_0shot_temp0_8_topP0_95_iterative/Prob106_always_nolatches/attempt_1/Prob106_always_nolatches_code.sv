
// ---------------------------------------------------------------------------
//  TopModule
//  -----------
//  Recognises the 16‑bit PS/2 scancodes of the arrow keys and asserts one
//  of the four outputs (left, down, right, up).  All other scancodes clear
//  the outputs.
//
//  Inputs:
//      scancode : 16‑bit PS/2 scancode (two bytes)
//  Outputs:
//      left, down, right, up  – each a single bit flag
//
//  The module uses purely combinational logic (no clock required).
// ---------------------------------------------------------------------------

module TopModule (
    input  wire [15:0] scancode,
    output reg        left,
    output reg        down,
    output reg        right,
    output reg        up
);

    // combinational logic: evaluate scancode whenever it changes
    always @(*) begin
        // default – no arrow key
        left  = 1'b0;
        down  = 1'b0;
        right = 1'b0;
        up    = 1'b0;

        // recognise the four arrow keys
        case (scancode)
            16'hE06B: left  = 1'b1;   // left arrow
            16'hE072: down  = 1'b1;   // down arrow
            16'hE074: right = 1'b1;   // right arrow
            16'hE075: up    = 1'b1;   // up arrow
            default:  ;               // leave all outputs 0
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
