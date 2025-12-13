
// 64‑bit arithmetic shift register with synchronous load
// Author: <Your Name>
// Date: <Date>
//
// Description:
//   * load  – synchronous load of the 64‑bit data input
//   * ena   – enables shifting when load is low
//   * amount – selects shift direction and magnitude
//   * q     – current contents of the shift register
//
// Note: All operations are performed on the rising edge of clk.

module TopModule (
    input  wire        clk,      // Clock (positive edge triggered)
    input  wire        load,     // Synchronous load (active high)
    input  wire        ena,      // Enable shift (active high)
    input  wire [1:0]  amount,   // Shift control
    input  wire [63:0] data,     // Data to load
    output reg  [63:0] q         // Shift register contents
);

    // Synchronous process
    always @(posedge clk) begin
        if (load) begin
            // Load new data
            q <= data;
        end
        else if (ena) begin
            // Perform shift according to amount
            case (amount)
                2'b00: q <= q << 1;                     // Shift left by 1
                2'b01: q <= q << 8;                     // Shift left by 8
                2'b10: q <= {q[63], q[63:1]};           // Arithmetic shift right by 1
                2'b11: q <= {8{q[63]}, q[63:8]};        // Arithmetic shift right by 8
                default: q <= q;                       // Should never happen
            endcase
        end
        // else: hold current value (no action needed)
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
