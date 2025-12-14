
`timescale 1ns/1ps
module TopModule (
    input  wire mode,      // 1 → heating, 0 → cooling
    input  wire too_cold,  // asserted when temperature is too low
    input  wire too_hot,   // asserted when temperature is too high
    input  wire fan_on,    // user‑requested fan
    output wire heater,    // heater ON/OFF
    output wire aircon,    // air‑conditioner ON/OFF
    output wire fan        // blower fan ON/OFF
);

// Heater is on only in heating mode and when the room is too cold
assign heater = mode & too_cold;

// Air‑conditioner is on only in cooling mode and when the room is too hot
assign aircon = (~mode) & too_hot;

// Fan is on if either the heater or the air‑con is on,
// or if the user explicitly requests it.
assign fan = fan_on | heater | aircon;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
