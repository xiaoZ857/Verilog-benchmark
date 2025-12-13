
module TopModule (
    input clk,
    input reset,
    output reg [4:0] q
);

    // Always block triggered on positive edge of clock or asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the LFSR to 1 (binary 00001)
            q <= 5'b00001;
        end else begin
            // Calculate new bit values for taps and shift right
            // Tap positions are 5 and 3, which correspond to q[4] and q[2]
            // XOR the tapped bits with the LSB before shifting
            q[4:1] <= {q[3], q[2], q[1], q[0]};
            q[0] <= q[4] ^ q[2];
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
