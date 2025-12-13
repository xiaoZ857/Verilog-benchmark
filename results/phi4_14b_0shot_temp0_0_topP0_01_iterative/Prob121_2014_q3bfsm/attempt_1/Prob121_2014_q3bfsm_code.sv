
module TopModule (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    // Current state and next state registers
    reg [2:0] y, next_y;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            y <= S0; // Reset to initial state 000
        end else begin
            y <= next_y;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (y)
            S0: begin
                next_y = (x == 0) ? S0 : S1;
                z = 0;
            end
            S1: begin
                next_y = (x == 0) ? S1 : S4;
                z = 0;
            end
            S2: begin
                next_y = (x == 0) ? S2 : S1;
                z = 0;
            end
            S3: begin
                next_y = (x == 0) ? S1 : S2;
                z = 1;
            end
            S4: begin
                next_y = (x == 0) ? S3 : S4;
                z = 1;
            end
            default: begin
                next_y = S0; // Default case to handle unexpected states
                z = 0;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
