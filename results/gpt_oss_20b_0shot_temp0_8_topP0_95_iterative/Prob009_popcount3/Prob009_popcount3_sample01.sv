
// --------------------------------------------------------------
//  TopModule
//  3‑bit population counter (counts the number of ‘1’ bits in `in`)
//  Output `out` is a 2‑bit vector holding the result (0…3)
// --------------------------------------------------------------
module TopModule (
    input  wire [2:0] in,   // 3‑bit input vector
    output wire [1:0] out   // 2‑bit pop‑count result
);

    // Simple combinational implementation:
    //  out = in[0] + in[1] + in[2]
    //  The addition yields a 3‑bit result (0–3); assigning to 2 bits
    //  automatically truncates the MSB, which is always 0 for this range.
    assign out = in[0] + in[1] + in[2];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
