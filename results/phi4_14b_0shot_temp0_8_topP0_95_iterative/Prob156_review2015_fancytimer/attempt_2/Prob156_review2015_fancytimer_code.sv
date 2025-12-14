
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count, // Current remaining time
  output reg counting,   // Indicates if we are in the counting process
  output reg done,       // Indicates when the countdown is complete
  input wire ack          // Acknowledge signal from user
);

    typedef enum logic[2:0] {
        IDLE = 3'b000,
        DETECT_PATTERN = 3'b001,
        SHIFT_DELAY = 3'b010,
        COUNTING = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;

    state_t current_state, next_state;
    
    reg [3:0] delay;     // Holds the duration to count for (in units of 1000 clk cycles)
    reg [2:0] pattern_det; // Stores last 4 bits to detect pattern
    reg [12:0] cycle_counter; // Counts down from delay*1000 to zero

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
            pattern_det <= 3'b000;
            delay <= 4'd0;
            cycle_counter <= 13'd0;
        end else begin
            current_state <= next_state;

            if (current_state == COUNTING) begin
                // Counting logic
                if (cycle_counter > 0) begin
                    cycle_counter <= cycle_counter - 1;
                    count <= cycle_counter[12:9]; // Extract the upper nibble
                end else if (count == 4'd0) begin
                    done <= 1'b1; // Indicate completion
                end else begin
                    cycle_counter <= delay * 13'd1000; // Reload with remaining cycles after decrement
                    count <= count - 1;
                end
            end

            if ((current_state != COUNTING) || (cycle_counter == 13'd0 && count == 4'd0)) begin
                done <= 1'b0; // Reset 'done' when not in counting or finished counting
            end

            if (current_state == WAIT_ACK && ack) begin
                pattern_det <= 3'b000;
                delay <= 4'd0;
            end

        end
    end

    always_comb begin
        next_state = current_state; // Default: stay in the same state
        counting = 1'b0; // Default: not counting
        case (current_state)
            IDLE: begin
                if (pattern_det == 3'b101) begin // Detecting pattern 1101, least significant bit first
                    next_state = SHIFT_DELAY;
                end else begin
                    pattern_det = {pattern_det[1:0], data}; // Shift in new bit
                end
            end

            DETECT_PATTERN: next_state = IDLE; // Already handled in IDLE state logic
            
            SHIFT_DELAY: begin
                if (cycle_counter == 13'd0) begin // Assuming we have a mechanism to know we are done shifting
                    counting <= 1'b1;
                    cycle_counter = delay * 13'd1000; // Prepare for counting
                    next_state = COUNTING;
                end else begin
                    delay = {delay[2:0], data}; // Shift in new bit as msb
                end
            end

            COUNTING: begin
                if (cycle_counter == 13'd0 && count == 4'd0) begin
                    next_state = WAIT_ACK;
                end
            end
            
            WAIT_ACK: begin
                if (!ack) begin
                    next_state = IDLE; // Wait until acknowledgment
                end
            end

        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
