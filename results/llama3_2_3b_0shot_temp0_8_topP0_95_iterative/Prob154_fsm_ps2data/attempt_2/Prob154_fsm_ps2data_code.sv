
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
module FSM (
    input clk,
    input in,
    output reg [2:0] state, // 3-state machine to track the received bytes
    output reg done, // signal to indicate when a message is fully received
    output reg [23:16] out_bytes // output message buffer
);

reg [7:0] in_byte;
reg [23:16] out_bytes_buffer; // internal buffer for storing the message

initial state = 2'b00;
always @(posedge clk) begin // on rising edge of clock
    if (state == 2'b00 && in[3:6] == 4'b1) begin // first byte found, reset to zero bytes received
        state <= 2'b01;
    } else if (state == 2'b01 && in[7:9] == 3'b1) begin // second byte found, increment bytes received
        state <= 2'b10;
    } else if (state == 2'b10 && in[10:12] == 3'b1) begin // third byte found, signal message done and fill output buffer
        done <= 1'b1;
        out_bytes_buffer <= in[9:1];
    end

    if (!done) begin // not yet done with this message
        out_bytes <= {in_byte[in_byte[4:7]], in_byte[in_byte[8:11]], in_byte[in_byte[12:15]], out_bytes_buffer};
    end
end

assign out_bytes[23:16] = out_bytes_buffer;
assign out_bytes[15:8] = out_bytes_buffer;
assign out_bytes[7:0] = out_bytes_buffer;

always @(posedge clk) begin // always output the next byte from input signal
    in_byte <= in;
end

// VERILOG-EVAL: endmodule not found
