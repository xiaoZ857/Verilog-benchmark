
module TopModule(
    input clk, // Positive clock/clk triggered signal
    input load, // Load flag to update the counter value
    input [9:0] data, // 10-bit data representing the number of clock cycles
    output tc      // Output signal indicating whether the timer has expired
);

reg [9:0] counter; // Internal 10-bit down-counter

always @(posedge clk) begin // Clock edge triggered
    if (load == 1) begin // Load new value into the counter
        counter <= data;
    else if (counter != 0) begin // Decrement the counter
        counter <= counter - 1;
    end
end

assign tc = (counter == 0); // Output signal indicating whether the timer has expired

endmodule

// VERILOG-EVAL: errant inclusion of module definition
