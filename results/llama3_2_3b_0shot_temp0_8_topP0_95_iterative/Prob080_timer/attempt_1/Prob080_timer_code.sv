
module TopModule(
    input clk,            // Clock signal
    input load,           // Load signal to reset or change the timer value
    input [9:0] data,      // Timer duration in clock cycles
    output tc             // Terminal count signal indicating whether the timer has timed out
);

reg[10:0] counter;     // 11-bit down-counter

initial begin
    $readmemh "counter.txt"; // Initialize counter with a default value (e.g., 10000)
end

always @(posedge clk or load) begin
    if(load) begin
        // Load the timer duration into the counter
        counter = data;
    end else begin
        // Decrement the counter by 1
        counter <= counter - 1;
    end
    
    // Assert tc signal when the counter reaches 0
    tc = (counter == 0);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
