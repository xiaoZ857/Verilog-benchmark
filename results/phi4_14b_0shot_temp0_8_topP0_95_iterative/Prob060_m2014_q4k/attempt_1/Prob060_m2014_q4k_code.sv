
module TopModule (
    input clk,
    input resetn,  // Active-low synchronous reset
    input in,      // Input to the shift register
    output out     // Output from the last D flip-flop
);

    reg [3:0] shift_reg; // 4-bit register to hold the shift register

    assign out = shift_reg[3]; // Connect the output of the last flip-flop to 'out'

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Synchronous active-low reset: Reset all bits in the shift register
            shift_reg <= 4'b0000;
        end else begin
            // Shift left operation and loading new input to the first bit
            shift_reg <= {shift_reg[2:0], in};
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
