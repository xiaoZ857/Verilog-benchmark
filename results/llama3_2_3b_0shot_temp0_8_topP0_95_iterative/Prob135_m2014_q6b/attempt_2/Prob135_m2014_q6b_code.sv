
module TopModule (
    input [3:1] y,
    input w,
    output reg Y2
);

    always_comb begin
        if (w == 0) begin // no change in state when w = 0
            if (y[3:1] == 4'b000)    // A
                Y2 = y[2];
            else if (y[3:1] == 4'b001) // B
                Y2 = 0;
            else if (y[3:1] == 4'b010) // C
                Y2 = 0;
            else if (y[3:1] == 4'b011) // D
                Y2 = y[2];
            else if (y[3:1] == 4'b100) // E
                Y2 = y[2];
            else if (y[3:1] == 4'b101) // F
                Y2 = 0;
        end else begin // transition when w = 1
            if (y[3:1] == 4'b000)    // A -> B
                Y2 = y[2];
            else if (y[3:1] == 4'b001) // B -> C
                Y2 = 0;
            else if (y[3:1] == 4'b010) // C -> D
                Y2 = 0;
            else if (y[3:1] == 4'b011) // D -> A
                Y2 = y[2];
            else if (y[3:1] == 4'b100) // E -> D
                Y2 = y[2];
            else if (y[3:1] == 4'b101) // F -> D
                Y2 = 0;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
