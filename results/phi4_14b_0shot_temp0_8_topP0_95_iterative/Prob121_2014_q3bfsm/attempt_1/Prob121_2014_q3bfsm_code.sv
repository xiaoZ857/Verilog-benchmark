
module TopModule (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    parameter S0 = 3'b000; // State 0
    parameter S1 = 3'b001; // State 1
    parameter S2 = 3'b010; // State 2
    parameter S3 = 3'b011; // State 3
    parameter S4 = 3'b100; // State 4

    reg [2:0] y; // Current state register

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous active high reset
            y <= S0;
        end else begin
            case (y)
                S0: begin
                    if (x == 1'b0) 
                        y <= S0;
                    else 
                        y <= S1;
                    z <= 1'b0;
                end

                S1: begin
                    if (x == 1'b0) 
                        y <= S1;
                    else 
                        y <= S4;
                    z <= 1'b0;
                end

                S2: begin
                    if (x == 1'b0) 
                        y <= S2;
                    else 
                        y <= S1;
                    z <= 1'b0;
                end

                S3: begin
                    if (x == 1'b0)
                        y <= S1;
                    else 
                        y <= S2;
                    z <= x; // Output is 1 when transitioning from S3 and x=1
                end

                S4: begin
                    if (x == 1'b0) 
                        y <= S3;
                    else 
                        y <= S4;
                    z <= 1'b1;
                end

                default: begin
                    y <= S0; // Default case to handle any undefined states
                    z <= 1'b0;
                end
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
