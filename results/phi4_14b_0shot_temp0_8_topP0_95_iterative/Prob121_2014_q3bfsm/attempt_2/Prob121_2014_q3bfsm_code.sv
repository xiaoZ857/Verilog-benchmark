
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous active high reset
        y <= S0;
    end else begin
        case (y)
            S0: begin
                if (x == 1'b0) 
                    y <= S0; // Stay in S0 when x=0
                else 
                    y <= S1; // Transition to S1 when x=1
                z <= 1'b0; // Output should be 0 in state S0
            end

            S1: begin
                if (x == 1'b0) 
                    y <= S1; // Stay in S1 when x=0
                else 
                    y <= S4; // Transition to S4 when x=1
                z <= 1'b0; // Output should be 0 in state S1
            end

            S2: begin
                if (x == 1'b0) 
                    y <= S2; // Stay in S2 when x=0
                else 
                    y <= S1; // Transition to S1 when x=1
                z <= 1'b0; // Output should be 0 in state S2
            end

            S3: begin
                if (x == 1'b0)
                    y <= S1; // Transition to S1 when x=0
                else 
                    y <= S2; // Transition to S2 when x=1
                z <= x; // Output is equal to input x in state S3
            end

            S4: begin
                if (x == 1'b0) 
                    y <= S3; // Transition to S3 when x=0
                else 
                    y <= S4; // Stay in S4 when x=1
                z <= 1'b1; // Output should be 1 in state S4
            end

            default: begin
                y <= S0; // Default case to handle any undefined states
                z <= 1'b0;
            end
        endcase
    end
endmodule
