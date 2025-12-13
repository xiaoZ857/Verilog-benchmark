
// TopModule.v
// Detects the four arrow‑key scancodes from a PS/2 keyboard.
// The module is combinational – it reacts immediately to changes
// on the 16‑bit input `scancode`.

module TopModule (
    input  wire [15:0] scancode,   // 16‑bit scancode from the keyboard
    output reg  left,              // left arrow pressed
    output reg  down,              // down arrow pressed
    output reg  right,             // right arrow pressed
    output reg  up                 // up arrow pressed
);

    // Combinational logic – no clock needed.
    // The always @(*) block is inferred as a combinational block.
    always @(*) begin
        // Default: no arrow key pressed
        left  = 1'b0;
        down  = 1'b0;
        right = 1'b0;
        up    = 1'b0;

        // Decode the scancode
        case (scancode)
            16'hE06B: left  = 1'b1;   // left arrow
            16'hE072: down  = 1'b1;   // down arrow
            16'hE074: right = 1'b1;   // right arrow
            16'hE075: up    = 1'b1;   // up arrow
            default:  ;              // keep all outputs low
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
