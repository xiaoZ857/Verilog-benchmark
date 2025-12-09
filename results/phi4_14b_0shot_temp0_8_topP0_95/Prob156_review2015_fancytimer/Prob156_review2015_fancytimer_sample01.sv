
module TopModule (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_PATTERN = 3'b001,
        SHIFT_BITS = 3'b010,
        COUNTING = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;

    // Registers for state and pattern detection
    state_t current_state, next_state;
    logic [7:0] shift_register; // To hold the detected pattern and delay bits
    logic [3:0] delay_value;
    logic [19:0] cycle_counter; // 20-bit counter to count up to 6000 cycles

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                counting = 1'b0;
                done = 1'b0;
                shift_register = 8'd0; // Clear the register
                if (reset) begin
                    next_state = IDLE;
                end else if ((shift_register == 8'hD2)) begin // Pattern is '1101' followed by zeros (D2 in hex)
                    next_state = SHIFT_BITS;
                end else begin
                    shift_register <= {shift_register[6:0], data}; // Shift left and add new bit
                    next_state = DETECT_PATTERN;
                end
            end

            DETECT_PATTERN: begin
                counting = 1'b0;
                done = 1'b0;
                shift_register <= {shift_register[6:0], data};
                if ((shift_register == 8'hD2)) // Pattern is detected
                    next_state = SHIFT_BITS;
                else
                    next_state = DETECT_PATTERN;
            end

            SHIFT_BITS: begin
                counting = 1'b0;
                done = 1'b0;
                shift_register <= {shift_register[6:0], data}; // Read 4 bits for delay
                if (shift_register[7]) // MSB indicates we are in the last bit to read
                    next_state = COUNTING;
                else
                    next_state = SHIFT_BITS;
            end

            COUNTING: begin
                counting = 1'b1; // Counting is active
                done = 1'b0;
                delay_value = shift_register[3:0]; // Extract delay value
                if (cycle_counter == ((delay_value + 1) * 20'd1000) - 1)
                    next_state = WAIT_ACK;
                else
                    next_state = COUNTING;
            end

            WAIT_ACK: begin
                counting = 1'b0;
                done = ack ? 1'b1 : 1'b0; // Set done when ack is received
                if (ack) 
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end

            default: next_state = IDLE;
        endcase
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            cycle_counter <= 20'd0;
        else if (current_state == COUNTING)
            cycle_counter <= cycle_counter + 1;
        else if ((current_state == WAIT_ACK && ack))
            cycle_counter <= 20'd0; // Reset counter on ACK
    end

    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: count <= 4'bxxxx;
            DETECT_PATTERN: count <= 4'bxxxx;
            SHIFT_BITS: count <= 4'bxxxx;

            COUNTING: begin
                // Calculate the current countdown value based on cycles remaining
                if (cycle_counter < ((delay_value + 1) * 20'd1000 - 1))
                    count <= delay_value - cycle_counter[19:16];
                else
                    count <= delay_value; // Hold during transition
            end

            WAIT_ACK: begin
                count <= 4'bxxxx;
            end

            default: count <= 4'bxxxx;
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
