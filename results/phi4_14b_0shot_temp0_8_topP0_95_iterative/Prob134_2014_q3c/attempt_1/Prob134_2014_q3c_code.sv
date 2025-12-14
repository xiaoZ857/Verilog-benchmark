
module TopModule (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    always @(posedge clk) begin
        case (y)
            3'b000: if (x == 1'b0) Y0 <= 1'b0; else Y0 <= 1'b1;
            3'b001: if (x == 1'b0) Y0 <= 1'b1; else Y0 <= 1'b0;
            3'b010: Y0 <= 1'b0;
            3'b011: if (x == 1'b0) Y0 <= 1'b1; else Y0 <= 1'b0;
            3'b100: Y0 <= 1'b1;
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
