
`timescale 1ns / 1ps

module TopModule (
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

always_comb begin
    heater = (mode == 1) & too_cold;
    aircon = (mode == 0) & too_hot;
    
    // Fan turns on if either heating or cooling is active, or if fan_on input is asserted
    fan = ((heater | aircon) || fan_on);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
