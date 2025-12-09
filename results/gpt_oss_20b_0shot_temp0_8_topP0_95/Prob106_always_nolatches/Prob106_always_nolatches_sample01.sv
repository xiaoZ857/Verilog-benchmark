
//  TopModule.v
//  Recognises the four arrow‑key scancodes from a PS/2 keyboard
//  and asserts the corresponding output signal.
//
//  scancode : 16‑bit input containing the two most recent bytes from the keyboard
//  left, down, right, up : one‑bit outputs that are asserted (1) when the
//                          corresponding arrow key has just been pressed

module TopModule (
    input  wire [15:0] scancode,
    output reg  left,
    output reg  down,
    output reg  right,
    output reg  up
);

    // Combinational logic – no clock needed
    always @(*) begin
        // default – no key pressed
        left  = 1'b0;
        down  = 1'b0;
        right = 1'b0;
        up    = 1'b0;

        case (scancode)
            16'hE06B: left  = 1'b1;   // left arrow
            16'hE072: down  = 1'b1;   // down arrow
            16'hE074: right = 1'b1;   // right arrow
            16'hE075: up    = 1'b1;   // up arrow
            default: ;                // no action – all outputs stay 0
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
