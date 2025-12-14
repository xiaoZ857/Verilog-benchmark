
//==========================================================================
// 100‑bit left/right rotator
//   • Synchronous load (active‑high)
//   • 2‑bit enable selects rotation direction
//       2'b01 → rotate right  by one bit
//       2'b10 → rotate left   by one bit
//       2'b00 or 2'b11 → no rotation
//
//   The register is a circular buffer – the bit that is shifted out on one
//   side is shifted in on the opposite side.
//
//   All operations are triggered on the rising edge of **clk**.
//==========================================================================

module TopModule (
    input  wire        clk,          // clock
    input  wire        load,         // synchronous active‑high load
    input  wire [1:0]  ena,          // enable: 01‑right, 10‑left
    input  wire [99:0] data,         // data to be loaded
    output reg  [99:0] q             // register contents
);

    // -------------------------------------------------------------------
    // Synchronous process
    // -------------------------------------------------------------------
    always @(posedge clk) begin
        if (load) begin
            // Load the external data
            q <= data;
        end
        else begin
            // Rotation depending on ena
            case (ena)
                2'b01:   // Rotate right:  MSB <= LSB, shift all bits right
                    q <= { q[0],   q[99:1] };
                2'b10:   // Rotate left:   LSB <= MSB, shift all bits left
                    q <= { q[98:0], q[99] };
                default: // 2'b00 or 2'b11 – no rotation
                    q <= q;
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
