
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);
We'll implement a finite state machine (FSM) with states for:  
1. **IDLE** 每 waiting for the start sequence "1101".  
2. **SHIFT_DELAY** 每 shifting in the next 4 bits (MSB first) after detecting the start sequence.  
3. **COUNTING** 每 counting down the delay cycles.  
4. **DONE** 每 asserting `done` and waiting for `ack`.  

We'll also need:  
- A shift register to detect "1101".  
- A shift register to capture `delay[3:0]`.  
- A counter for the 1000-cycle sub-intervals.  
- A down-counter for the remaining delay value (from `delay` down to 0).  

Here＊s the implementation:  

    // FSM states
    localparam S_IDLE       = 2'b00;
    localparam S_SHIFT_DELAY = 2'b01;
    localparam S_COUNTING   = 2'b10;
    localparam S_DONE       = 2'b11;
    
    reg [1:0] state, next_state;
    
    // Shift register for sequence detection (1101)
    reg [3:0] seq_reg;
    wire seq_detected = (seq_reg == 4'b1101);
    
    // Shift register for delay bits
    reg [3:0] delay_reg;
    reg [2:0] delay_bit_cnt;  // counts 0..3 for shifting 4 bits
    
    // Delay value storage
    reg [3:0] delay_val;
    
    // 1000-cycle counter (0 to 999)
    reg [9:0] cycle_cnt;
    wire cycle_done = (cycle_cnt == 10'd999);
    
    // Delay down-counter (delay_val down to 0)
    reg [3:0] rem_time;
    
    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Sequence shift register
    always @(posedge clk) begin
        if (reset) begin
            seq_reg <= 4'b0;
        end else if (state == S_IDLE) begin
            seq_reg <= {seq_reg[2:0], data};
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (seq_detected)
                    next_state = S_SHIFT_DELAY;
            end
            S_SHIFT_DELAY: begin
                if (delay_bit_cnt == 3'd3)
                    next_state = S_COUNTING;
            end
            S_COUNTING: begin
                if (rem_time == 4'd0 && cycle_done)
                    next_state = S_DONE;
            end
            S_DONE: begin
                if (ack)
                    next_state = S_IDLE;
            end
        endcase
    end
    
    // Delay shift register and bit counter
    always @(posedge clk) begin
        if (reset) begin
            delay_reg <= 4'b0;
            delay_bit_cnt <= 3'b0;
            delay_val <= 4'b0;
        end else begin
            case (state)
                S_IDLE: begin
                    delay_bit_cnt <= 3'b0;
                end
                S_SHIFT_DELAY: begin
                    delay_reg <= {delay_reg[2:0], data};
                    delay_bit_cnt <= delay_bit_cnt + 3'b1;
                    if (delay_bit_cnt == 3'd3) begin
                        delay_val <= {delay_reg[2:0], data}; // final captured delay
                    end
                end
                default: begin
                    // hold values
                end
            endcase
        end
    end
    
    // Cycle counter (0 to 999)
    always @(posedge clk) begin
        if (reset) begin
            cycle_cnt <= 10'b0;
        end else begin
            if (state == S_COUNTING) begin
                if (cycle_done)
                    cycle_cnt <= 10'b0;
                else
                    cycle_cnt <= cycle_cnt + 10'b1;
            end else begin
                cycle_cnt <= 10'b0;
            end
        end
    end
    
    // Remaining time counter
    always @(posedge clk) begin
        if (reset) begin
            rem_time <= 4'b0;
        end else begin
            if (state == S_SHIFT_DELAY && delay_bit_cnt == 3'd3) begin

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
