
// TopModule.v
// -------------
// A simple combinational thermostat controller.
//   • mode      : 1 → heating, 0 → cooling
//   • too_cold  : heater should be on (only in heating mode)
//   • too_hot   : air‑con should be on (only in cooling mode)
//   • fan_on    : user‑requested fan (always on when set)
//   • heater, aircon, fan : outputs

module TopModule (
    input  wire mode,      // 1 = heating, 0 = cooling
    input  wire too_cold,  // asserted when temperature is too low
    input  wire too_hot,   // asserted when temperature is too high
    input  wire fan_on,    // user request to turn fan on
    output wire heater,    // heater control
    output wire aircon,    // air‑con control
    output wire fan        // fan control
);

// Heater is on only in heating mode and when it is too cold
assign heater = mode & too_cold;

// Air‑con is on only in cooling mode and when it is too hot
assign aircon = ~mode & too_hot;

// Fan is on if either the heater or the air‑con is on,
// or if the user explicitly requests it
assign fan = heater | aircon | fan_on;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
