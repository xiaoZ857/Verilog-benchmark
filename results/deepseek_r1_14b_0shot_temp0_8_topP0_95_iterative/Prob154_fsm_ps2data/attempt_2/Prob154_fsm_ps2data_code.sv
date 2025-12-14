
module TopModule (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

enum {
    Idle,
    State1,
    State2,
    Done
} state = Idle;

reg [7:0] byte1, byte2, byte3;
reg [23:0] message;

always @ (posedge clk) begin
    if (reset == 1) begin
        state <= Idle;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        done <= 0;
        out_bytes <= 0;
    end else case (state) begin
        Idle:
            if (in[3] == 1) begin
                state <= State1;
                byte1 <= in;
            end
        State1:
            if (in[3] == 1) begin
                state <= State2;
                byte2 <= in;
            end
        State2:
            if (in[3] == 1) begin
                state <= Done;
                byte3 <= in;
            end
        Done:
            begin
                done <= 1;
                message = {byte1, byte2, byte3};
                out_bytes <= message;
                // Reset after one cycle to prevent holding done indefinitely
                state <= Idle;
            end
    endcase
end

// Set out_bytes as don't-care when not

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
