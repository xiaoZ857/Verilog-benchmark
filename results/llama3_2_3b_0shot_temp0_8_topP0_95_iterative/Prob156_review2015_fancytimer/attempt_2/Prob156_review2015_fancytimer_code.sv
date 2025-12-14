
module TopModule (
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [7:0] delay;
wire [7:0] start_seq;
wire [7:0] next_state;

// Start sequence detection
always @(*) begin
    if (data[2] & data[1] & data[0]) start_seq <= 8'd1101;
    else start_seq <= 8'd0000;
end

// Shift in delay
always @(posedge clk or start_seq) begin
    if (start_seq == 8'd1101 && data[4:0] != 7'b01110000) // ignore the wrong pattern
        received_delay <= {data[3:0], delay};
    else 
        received_delay <= delay;
end

// State machine
integer state;
assign next_state = (start_seq == 8'd0000 ? 
                    (delay > 0 ? counting : done) : (start_seq != 8'd0000 && delay >= 1 ? 1'b0 : 2'b01));

always @(posedge clk or start_seq or ack or reset) begin
    if (reset || (start_seq == 8'd1101 && received_delay[3:0] < 'd4)) 
        state <= 0;
    else if ((ack && start_seq != 8'd0000) || count[0] == 1000 && (state == 2'b01)) begin
        counting <= 1'b0;
        done <= 1'b1;
        state <= 0;
    end 
    else if (counting) begin
        integer time_left = (delay - count) * 1000 + count[3:0];
        count <= count + 1;

        if (time_left == 0 || count[7] >= count[6]) // all counting done, start next sequence detection
            state <= 2'b01;
    end 
    else if (state == 2'b01) begin
        state <= 0;
        received_delay = delay;
    end 
end

// Displaying remaining time and output signals
assign count = {count[3:0], count[7] + 'd1};

endmodule

// VERILOG-EVAL: errant inclusion of module definition
