
// Define a module that implements the thermostat control circuit.
// This module takes in inputs from the user and outputs the state of the heating/cooling system.

module TopModule(
    // Inputs:
    input mode,      // Mode: 1 for heating, 0 for cooling
    input too_cold,  // Too cold signal (1) or 0
    input too_hot,   // Too hot signal (1) or 0
    input fan_on     // Requested state of the fan (1) or 0
    // Outputs:
    output heater     // State of the heating element (1) or 0
    output aircon     // State of the air conditioning element (1) or 0
    output fan        // State of the blower fan (1) or 0
);

// Instantiate a local instance of the thermostat control logic.
localinst top_ththerat;
top_ththerat: TopThermostat(
    .mode(mode),
    .too_cold(too_cold),
    .too_hot(too_hot)
);

// Assign outputs based on mode and signals.
assign heater = top_ththerat.heater;
assign aircon = top_ththerat.aircon;
assign fan = fan_on || top_ththerat.fan; // fan is always turned on when requested, unless heater or AC are on

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
