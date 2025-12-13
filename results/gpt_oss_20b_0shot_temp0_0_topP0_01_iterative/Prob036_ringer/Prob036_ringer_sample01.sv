
// TopModule.v
// ---------------
//  Controls a cellphone ringer and vibration motor.
//  When an incoming call is detected (ring = 1) the circuit must
//  enable **exactly one** of the two outputs:
//
//      • If vibrate_mode = 1  →  motor = 1, ringer = 0
//      • If vibrate_mode = 0  →  ringer = 1, motor = 0
//
//  When ring = 0 both outputs are forced low.
//
//  The design is purely combinational – no clock is required.

module TopModule (
    input  wire ring,          // Incoming call indicator
    input  wire vibrate_mode,  // 1 = vibrate mode, 0 = normal mode
    output wire ringer,        // Ringer output
    output wire motor          // Vibration motor output
);

    // Simple combinational logic
    assign ringer = ring & ~vibrate_mode;   // Ringer on only when ring and not vibrate
    assign motor  = ring &  vibrate_mode;   // Motor on only when ring and vibrate

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
