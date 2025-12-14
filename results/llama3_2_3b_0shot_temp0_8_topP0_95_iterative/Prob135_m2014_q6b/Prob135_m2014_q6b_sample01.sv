
module TopModule (
    input [3:1] y,
    input w,
    output reg Y2
);

    always_comb begin
        if (w == 0) begin // no change in state when w = 0
            case(y[3:2])
                00 : Y2 = y[1];      // A(0)
                01 : Y2 = y[2];      // A -> B
                10 : Y2 = 0;         // B(0)
                11 : Y2 = y[1];      // B -> D
            endcase
        else begin // transition when w = 1
            case(y[3:2])
                00 : Y2 = y[2];      // A(0) 
                01 : Y2 = y[2];      // A -> E
                10 : Y2 = y[2];      // B(0) 
                11 : Y2 = y[1];      // B -> D
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
