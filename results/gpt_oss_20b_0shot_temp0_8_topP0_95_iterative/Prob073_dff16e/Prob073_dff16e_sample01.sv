
// 16‑bit register with byte‑enable and synchronous active‑low reset
module TopModule (
    input          clk,        // clock
    input          resetn,     // active‑low synchronous reset
    input  [1:0]   byteena,    // byte‑enable: [1] upper byte, [0] lower byte
    input  [15:0]  d,          // data input
    output reg [15:0] q         // 16‑bit output register
);

    // Positive‑edge triggered, synchronous logic
    always @(posedge clk) begin
        if (!resetn) begin
            // Reset all bits to zero
            q <= 16'h0000;
        end else begin
            // Upper byte
            if (byteena[1])
                q[15:8] <= d[15:8];
            // Lower byte
            if (byteena[0])
                q[7:0] <= d[7:0];
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
