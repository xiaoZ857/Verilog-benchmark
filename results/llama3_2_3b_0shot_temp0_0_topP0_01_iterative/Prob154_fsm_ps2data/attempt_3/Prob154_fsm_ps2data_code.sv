
module TopModule(
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
reg [23:16] message;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        message <= 0;
        done <= 0;
    end else begin
        // Discard bytes until we see one with in[3]=1
        if (in[3] == 1) begin
            state <= 0;
            byte1 <= in[7:0];
            byte2 <= 0;
            byte3 <= 0;
            message <= 0;
            done <= 0;
        end else if (state == 0 && byte1 != 0) begin
            state <= 1;
            byte2 <= in[7:0];
            byte3 <= 0;
            message <= 0;
            done <= 0;
        end else if (state == 1 && byte2 != 0) begin
            state <= 2;
            byte3 <= in[7:0];
            message <= {byte1, byte2};
            done <= 0;
        end else if (state == 2 && byte3 != 0) begin
            state <= 0;
            byte1 <= 0;
            byte2 <= 0;
            byte3 <= 0;
            message <= message;
            done <= 1;
        end
    end
end

assign out_bytes = message;

assign done = (state == 2 && byte3 != 0);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
