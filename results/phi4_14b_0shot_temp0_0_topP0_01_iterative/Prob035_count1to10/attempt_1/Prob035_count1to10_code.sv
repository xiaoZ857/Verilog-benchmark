
module TopModule (
    input clk,
    input reset,
    output reg [3:0] q
);

    // Always block triggered by positive edge of clock or active-high reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the counter to 1 when reset is high
            q <= 4'b0001;
        end else begin
            // Increment the counter, wrap around from 10 to 1
            case (q)
                4'b1010: q <= 4'b0001; // When count reaches 10, set it back to 1
                default : q <= q + 1;   // Otherwise, increment by 1
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
