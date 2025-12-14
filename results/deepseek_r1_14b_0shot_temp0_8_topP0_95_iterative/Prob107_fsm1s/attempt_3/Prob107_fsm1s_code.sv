
`timescale 1ns/1ps

module TopModule (
    input clk,
    input in,
    input reset,
    output out
);

enum {
    B,
    A
} state, next_state;

reg out;
reg state_reg;

always @(posedge clk) begin
    if (reset) begin
        state_reg <= B;
        out <= 1;
    end else begin
        state_reg <= next_state;
        case (state_reg)
            B: begin
                out = 1;
                if (!in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            A: begin
                out = 0;
                if (!in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
        endcase
    end
end

initial begin
    state_reg = B;
    out = 1;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
