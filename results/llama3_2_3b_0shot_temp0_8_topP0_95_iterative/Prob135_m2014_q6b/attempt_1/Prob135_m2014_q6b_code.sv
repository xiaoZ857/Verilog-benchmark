
module TopModule (
    input [3:1] y,
    input w,
    output reg Y2
);

    always_comb begin
        if (w == 0) begin // no change in state when w = 0
            Y2 = y[2];
        end else begin // transition when w = 1
            case(y[3:1])
                4'b000 : Y2 = y[2]; // A or E, so next state is B
                4'b001 : Y2 = 0;   // C or D, so next state is C
                4'b010 : Y2 = 0;   // C or D, so next state is C
                4'b011 : Y2 = y[2]; // A or E, so next state is B
                4'b100 : Y2 = y[2]; // D -> F
                4'b101 : Y2 = 1;   // C -> E
                4'b110 : Y2 = y[2]; // C or D, so next state is C
                4'b111 : Y2 = y[2]; // D -> A
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
