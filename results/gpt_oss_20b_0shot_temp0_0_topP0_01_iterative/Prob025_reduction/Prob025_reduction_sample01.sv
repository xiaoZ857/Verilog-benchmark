
// ---------------------------------------------------------------------------
//  TopModule
//  ---------
//  Computes an even‑parity bit for an 8‑bit input word.
//  The parity bit is the XOR of all eight data bits.
//
//  Inputs:
//      in   : 8‑bit data word
//
//  Outputs:
//      parity : 1‑bit even‑parity (XOR of all bits of 'in')
// ---------------------------------------------------------------------------

module TopModule (
    input  wire [7:0] in,      // 8‑bit data input
    output wire       parity   // 1‑bit parity output
);

    // Combinational parity calculation
    assign parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^
                    in[4] ^ in[5] ^ in[6] ^ in[7];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
