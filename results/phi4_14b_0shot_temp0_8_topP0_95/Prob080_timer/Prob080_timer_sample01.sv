
module TopModule (
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    // Internal 10-bit counter register
    reg [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            // Load the counter with new data and reset terminal count
            counter <= data;
            tc <= 0;  // Reset terminal count when loading a new value
        end else if (counter > 0) begin
            // Decrement the counter only if it's greater than zero
            counter <= counter - 1;
        end

        // Set terminal count to 1 when counter reaches zero
        if (counter == 0) begin
            tc <= 1;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
