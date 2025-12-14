
module TopModule (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State definition
    typedef enum {
        WAITING = 0,
        RECEIVED_BYTE1 = 1,
        RECEIVED_BYTE2 = 2
    } state_t;

    state_t state, next_state;
    reg [7:0] byte1, byte2;
    wire done;

    // D-flip-flop for clocking
    always @ (posedge clk) begin
        if (reset) begin
            state <= WAITING;
            byte1 <= 0;
            byte2 <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            byte1 <= (state == RECEIVED_BYTE1) ? in : 0;
            byte2 <= (state == RECEIVED_BYTE2) ? in : 0;
            done <= (state == RECEIVED_BYTE2 && in[3] == 

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
