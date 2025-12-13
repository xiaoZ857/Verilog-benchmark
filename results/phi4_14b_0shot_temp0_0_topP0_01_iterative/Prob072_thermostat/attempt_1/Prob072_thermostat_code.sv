
module TopModule (
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(*) begin
    // Default outputs to 0 (off)
    heater = 0;
    aircon = 0;
    fan = 0;

    if (mode == 1) begin
        // Heating mode
        if (too_cold) begin
            heater = 1; // Turn on the heater if it's too cold
        end
        // Fan logic in heating mode
        if (heater || fan_on) begin
            fan = 1; // Turn on the fan if heater is on or user requests
        end
    end else begin
        // Cooling mode
        if (too_hot) begin
            aircon = 1; // Turn on the air conditioner if it's too hot
        end
        // Fan logic in cooling mode
        if (aircon || fan_on) begin
            fan = 1; // Turn on the fan if aircon is on or user requests
        end
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
