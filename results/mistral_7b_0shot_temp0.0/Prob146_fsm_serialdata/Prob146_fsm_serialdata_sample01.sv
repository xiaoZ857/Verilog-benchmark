

module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= START;
        out_byte <= 8'bx;
        done <= 0;
    end else if (state == START) begin
        if (in == 1'b0) begin
            state <= DATA;
        end
    end else if (state == DATA) begin
        out_byte[7 - data_bits] <= in;
        if (data_bits >= 8 && in == 1'b1) begin
            state <= STOP;
            data_bits <= 0;
        end else if (data_bits < 8) begin
            data_bits++;
        end
    end else if (state == STOP) begin
        if (in == 1'b1) begin
            done <= 1;
            state <= START;
        end
    end
end

reg [7:0] out_byte;
reg done;
reg data_bits; // counter for data bits
reg [1:0] state; // finite state machine states (START, DATA, STOP)

// State definitions
parameter START = 2'b00;
parameter DATA = 2'b01;
parameter STOP = 2'b10;

// VERILOG-EVAL: endmodule not found
