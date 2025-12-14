
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Synchronous active high reset to state 000
        y <= 3'b000;
    end else begin
        case (y)
            3'b000: begin
                if (x == 1'b0)
                    y <= 3'b000; // Stay in 000 when x=0
                else 
                    y <= 3'b001; // Transition to 001 when x=1
                z <= 1'b0; // Output should be 0 in state 000
            end

            3'b001: begin
                if (x == 1'b0)
                    y <= 3'b001; // Stay in 001 when x=0
                else 
                    y <= 3'b100; // Transition to 100 when x=1
                z <= 1'b0; // Output should be 0 in state 001
            end

            3'b010: begin
                if (x == 1'b0)
                    y <= 3'b010; // Stay in 010 when x=0
                else 
                    y <= 3'b001; // Transition to 001 when x=1
                z <= 1'b0; // Output should be 0 in state 010
            end

            3'b011: begin
                if (x == 1'b0)
                    y <= 3'b001; // Transition to 001 when x=0
                else 
                    y <= 3'b010; // Transition to 010 when x=1
                z <= x; // Output is equal to input x in state 011
            end

            3'b100: begin
                if (x == 1'b0)
                    y <= 3'b011; // Transition to 011 when x=0
                else 
                    y <= 3'b100; // Stay in 100 when x=1
                z <= 1'b1; // Output should be 1 in state 100
            end

            default: begin
                y <= 3'b000; // Default case to handle any undefined states
                z <= 1'b0;
            end
        endcase
    end
endmodule
