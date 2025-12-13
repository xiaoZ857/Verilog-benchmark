
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

typedef enum logic [2:0] {
    STATE_LOW = 3'b000,
    STATE_MID = 3'b001,
    STATE_HIGH = 3'b010,
    STATE_VHIGH = 3'b011
} state_t;

state_t current_state, next_state;
state_t previous_state;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0; // No need to open supplemental valve on reset
        current_state <= STATE_LOW;
    end else begin
        current_state <= next_state;

        case (current_state)
            STATE_LOW: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            STATE_MID: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= (previous_state == STATE_LOW) ? 1'b1 : 1'b0; // Open if rising from low
            end
            STATE_HIGH: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= (previous_state == STATE_MID) ? 1'b1 : 1'b0; // Open if rising from mid
            end
            STATE_VHIGH: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        endcase
    end
end

always_comb begin
    // Determine next state based on the highest active sensor
    if (s[3]) begin
        next_state = STATE_VHIGH; // Above s[3]
    end else if (s[2]) begin
        next_state = STATE_HIGH; // Between s[3] and s[2]
    end else if (s[1]) begin
        next_state = STATE_MID; // Between s[2] and s[1]
    end else begin
        next_state = STATE_LOW; // Below s[1]
    end

    previous_state = current_state;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
