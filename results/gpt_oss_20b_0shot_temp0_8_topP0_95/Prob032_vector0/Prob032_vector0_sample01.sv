
//  TopModule.v
//  Simple combinational splitter – forwards the 3‑bit vector unchanged
//  and also exposes each bit individually (o0 → vec[0], o1 → vec[1], o2 → vec[2]).

`timescale 1ns / 1ps

module TopModule (
    input  wire [2:0] vec,   // 3‑bit input vector
    output wire [2:0] outv,  // 3‑bit output (identical to vec)
    output wire       o2,    // vec[2]
    output wire       o1,    // vec[1]
    output wire       o0     // vec[0]
);

// Continuous assignments – purely combinational logic
assign outv = vec;      // forward the whole vector

assign o0 = vec[0];     // bit 0
assign o1 = vec[1];     // bit 1
assign o2 = vec[2];     // bit 2

endmodule

// VERILOG-EVAL: errant inclusion of module definition
