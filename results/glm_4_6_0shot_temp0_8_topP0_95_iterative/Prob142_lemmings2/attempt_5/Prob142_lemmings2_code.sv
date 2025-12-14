
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);
// State encoding
parameter WL = 2'b00;  // Walking Left
parameter WR = 2'b01;  // Walking Right
parameter FL = 2'b10;  // Falling from Left
parameter FR = 2'b11;  // Falling from Right

reg [1:0] state, next_state;

// Sequential logic for state transitions
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WL;  // Reset to walk left
    else
        state <= next_state;
end

// Combinational logic for next state and outputs
always @(*) begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    
    case (state)
        WL: begin
            walk_left = 1;
            if (ground) begin
                if (bump_left) next_state = WR;
                else next_state = WL;
            end else begin
                next_state = FL;
            end
        end
        
        WR: begin
            walk_right = 1;
            if (ground) begin
                if (bump_right) next_state = WL;
                else next_state = WR;
            end else begin
                next_state = FR;
            end
        end
        
        FL: begin
            aaah = 1;
            if (ground) next_state = WL;
            else next_state = FL;
        end
        
        FR: begin
            aaah = 1;
            if (ground) next_state = WR;
            else next_state = FR;
        end
        
        default: begin
            next_state = WL;
        end
    endcase
end

endmodule
