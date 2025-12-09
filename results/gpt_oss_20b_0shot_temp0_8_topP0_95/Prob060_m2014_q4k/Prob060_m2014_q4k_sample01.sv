
// 4‑bit synchronous shift register with active‑low reset
module TopModule (
    input  wire clk,     // positive‑edge clock
    input  wire resetn,  // active‑low synchronous reset
    input  wire in,      // serial data input
    output wire out      // serial data output (bit 3 of the shift register)
);

    // 4‑bit shift register
    reg [3:0] shift_reg;

    // Synchronous logic
    always @(posedge clk) begin
        if (!resetn)                     // active‑low reset
            shift_reg <= 4'b0000;
        else
            shift_reg <= {shift_reg[2:0], in};   // shift left
    end

    // Output assignment
    assign out = shift_reg[3];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
