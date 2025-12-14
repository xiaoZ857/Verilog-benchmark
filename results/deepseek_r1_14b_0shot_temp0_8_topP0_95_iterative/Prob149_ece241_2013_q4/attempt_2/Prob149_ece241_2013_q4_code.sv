
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

// State definition
typedef enum {
    LOWEST_LEVEL = 0,   // Below all sensors
    MIDDLE_LEVEL,      // Between s[2] and s[1]
    HIGHEST_LEVEL,     // Above s[3]
    ALL_SENSORS_HIGH   // All three sensors high (above s[3])
} state_t;

state_t current_state;
reg [3:1] previous_s;

// Initialize all outputs to 0
initial begin
    fr3 = 0;
    fr2 = 0;
    fr1 = 0;
    dfr = 0;
end

always @(posedge clk) begin
    if (reset) begin
        // Reset state: assumes water level is very low with all outputs asserted
        current_state <= LOWEST_LEVEL;
        previous_s <= 0;
    end else begin
        reg [3:1] current_s, new_previous_s;

        // Record current sensors and compute transitions
        current_s = s;
        new_previous_s = current_s ^ (previous_s & ~current_s);
        
        case (current_state)
            LOWEST_LEVEL:
                if (current_s != 0) begin
                    current_state <= MIDDLE_LEVEL;
                end

            MIDDLE_LEVEL:
                if (current_s == 2'b100) begin
                    current_state <= HIGHEST_LEVEL;
                end
                else if (current_s >= previous_s) begin
                    current_state <= ALL_SENSORS_HIGH;
                end

            HIGHEST_LEVEL:
                if (current_s != 3'b111) begin
                    current_state <= ALL_SENSORS_HIGH;
                end

            ALL_SENSORS_HIGH:
                if (~current_s) begin
                    current_state <= LOWEST_LEVEL;
                end

        endcase

        // Update previous sensors for next cycle
        previous_s <= new_previous_s;
    end
end

always @(*) begin
    case (current

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
