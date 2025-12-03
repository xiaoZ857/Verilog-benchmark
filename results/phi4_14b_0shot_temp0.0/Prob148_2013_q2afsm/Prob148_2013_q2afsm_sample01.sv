

module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

reg [2:0] current_state, next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        current_state <= 3'b000; // Reset to state A
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        3'b000: begin // State A
            if (r[1])
                next_state = 3'b001; // Transition to B
            else if (r[2])
                next_state = 3'b010; // Transition to C
            else if (!r[1] && !r[2] && !r[3])
                next_state = 3'b100; // Transition to D
            else
                next_state = 3'b000; // Remain in A
        end

        3'b001: begin // State B
            if (g1)
                next_state = r[1] ? 3'b001 : 3'b000; // Stay in B or go to A
            else
                next_state = 3'b000;
        end

        3'b010: begin // State C
            if (g2)
                next_state = r[2] ? 3'b010 : 3'b000; // Stay in C or go to A
            else
                next_state = 3'b000;
        end

        3'b100: begin // State D
            next_state = 3'b000; // Always transition back to A
        end

        default: 
            next_state = 3'b000; // Default to state A
    endcase
end

assign g[1] = (current_state == 3'b001) || (current_state == 3'b001 && r[1]);
assign g[2] = (current_state == 3'b010) || (current_state == 3'b010 && r[2]);
assign g[3] = (current_state == 3'b100) && (!r[1] && !r[2]);

endmodule
