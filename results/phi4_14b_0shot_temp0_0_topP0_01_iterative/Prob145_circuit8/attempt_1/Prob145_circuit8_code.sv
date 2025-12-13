
module TopModule (
    input wire clock,
    input wire a,
    output reg p,
    output reg q
);

reg last_a;

always @(posedge clock) begin
    // Set p to the current value of a on every rising edge of the clock
    p <= a;
    
    // If a was 1 during the last cycle, set q to the last value of p
    if (last_a == 1'b1) begin
        q <= p;
    end else begin
        // Otherwise, reset q to 0
        q <= 1'b0;
    end
    
    // Store the current value of a for use in the next cycle
    last_a <= a;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
