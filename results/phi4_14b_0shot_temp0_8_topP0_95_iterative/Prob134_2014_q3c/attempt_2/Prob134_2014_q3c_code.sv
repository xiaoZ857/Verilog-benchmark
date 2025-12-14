
module TopModule (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    always @(posedge clk) begin
        case (y)
            3'b000: Y0 <= x; // Next state LSB is x
            3'b001: Y0 <= ~x; // Next state LSB is inverted x
            3'b010: Y0 <= 1'b1; // Always goes to 001, LSB is 1
            3'b011: Y0 <= x; // Next state LSB matches x
            3'b100: Y0 <= 1'b1; // Always stays at 100, LSB is 1
        endcase
    end

    always @(*) begin
        case (y)
            3'b000, 3'b001, 3'b010: z = 1'b0;
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'bx; // Undefined state
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
