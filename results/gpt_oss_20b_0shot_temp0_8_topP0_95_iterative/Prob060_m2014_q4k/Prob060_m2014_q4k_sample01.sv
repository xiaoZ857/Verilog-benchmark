
// ---------------------------------------------------------------------------
// 4‑bit Shift Register
//  - Positive‑edge triggered
//  - Active‑low synchronous reset
//  - Data input:  in
//  - Data output: out (MSB of the shift register)
// ---------------------------------------------------------------------------

module TopModule (
    input  wire clk,     // Clock input
    input  wire resetn,  // Active‑low synchronous reset
    input  wire in,      // Data to shift in
    output wire out      // MSB of the shift register
);

    // 4‑bit shift register
    reg [3:0] shift_reg;

    // Synchronous logic
    always @(posedge clk) begin
        if (!resetn)                     // Active‑low reset
            shift_reg <= 4'b0;
        else
            shift_reg <= {shift_reg[2:0], in}; // Shift left, input goes to LSB
    end

    // Connect the MSB of the register to the output
    assign out = shift_reg[3];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
