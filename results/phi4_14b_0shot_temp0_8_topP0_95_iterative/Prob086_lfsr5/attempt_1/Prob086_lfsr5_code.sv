
module TopModule (
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset condition: Set LFSR to 1'b1 at the most significant bit position.
        q <= 5'b00001;
    end else begin
        // Shift right by one position and apply feedback logic with taps at positions 5 and 3.
        q[4] <= q[0];                   // MSB is feedback from LSB
        q[3:1] <= q[2:0];               // Middle bits simply shift right
        
        // Calculate the new value of LSB using XOR for tap positions
        q[0] <= q[4] ^ q[2];
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
