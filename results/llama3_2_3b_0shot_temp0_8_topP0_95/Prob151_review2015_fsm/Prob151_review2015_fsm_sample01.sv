
module TopModule(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

reg[3:0] state; // State (4-bit)
reg [7:0] timer_counter;

// Synchronous Reset
always @(posedge clk or reset)
if(reset) begin
    state <= 0;
    timer_counter <= 0;
end else
state <= state;

assign counting = ~done && (state == 3);

// Pattern recognition and shift enable
reg [1:0] pattern_detected;
reg[7:4] sequence_shifted;

always @(posedge clk) begin
    if(data == 1'd1 && data == 1'd0 && data == 1'd1 && data == 1'd0) begin // Pattern detected
        state <= 2; // Start waiting for pattern length
    end else if (state == 2) begin // Pattern length detection
        sequence_shifted[3] = (data & (1 << 4));
        sequence_shifted[2] = (data & (1 << 3));
        sequence_shifted[1] = (data & (1 << 2));
        if(sequence_shifted == 1'd1100) begin // Pattern length detected
            state <= 5; // Enable shift enable and waiting for done_counting
        end 
    end else 
    sequence_shifted[0:3] = data;
end

assign shift_ena = (state == 4);

// Counting
if(state == 3) begin // Waiting for count to complete
    timer_counter <= timer_counter + 1;
else if (state == 5) begin // Waiting for done_counting
    timer_counter <= timer_counter;
end

// Timeout detection and resetting
assign done = ~done_counting && (timer_counter >= 4);

if(ack == 1) state <= 0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
