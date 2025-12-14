
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
// Finite State Machine to search for message boundaries
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
    if (state == 2'b00 && in[1:3] == 3'b1) begin // first byte found, reset to zero bytes received
        state <= 2'b01;
    } else if (state == 2'b01 && in[4:6] == 3'b1) begin // second byte found, increment bytes received
        state <= 2'b10;
    } else if (state == 2'b10 && in[7:9] == 3'b1) begin // third byte found, signal message done and fill output buffer
        done <= 1'b1;
        out_bytes_buffer <= in[6:0];
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

endmodule

// Datapath module to output the message buffer on rising edge of done signal
module Datapath (
    input clk,
    input reset,
    input done,
    output reg [23:0] out_bytes
);

reg [7:0] temp_in;
reg [23:16] out_message; // temporary buffer for storing the final output

initial out_message = 25'b0;

assign temp_in = FSM.in_byte;
assign out_message[15:8] = FSM.out_bytes_buffer;
assign out_message[7:0] = FSM.in_byte[4:6];

always @(posedge done) begin // on rising edge of done
    if (out_message != 25'b0) begin // message not yet sent, wait for the next clock cycle
        out_bytes <= temp_in;
    end else begin // message is ready to be sent
        out_bytes <= out_message[7:0];
    end
end

assign out_bytes = out_message;

always @(posedge clk) begin // on falling edge of clock
    if (!done && FSM.state == 2'b10) begin // not done and last byte received, reset output buffer for the next message
        out_message <= 25'b0;
    end
end

assign reset = FSM.reset;

endmodule

// TopModule
module TopModule (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output done
);

reg FSM_state;
reg FSM_done;
reg FSM_out_bytes_buffer;

FSM fsm (
    .clk(clk),
    .in(in),
    .state(FSM_state),
    .done(FSM_done),
    .out_bytes(FSM_out_bytes_buffer)
);

Datapath datapath (
    .clk(clk),
    .reset(reset),
    .done(FSM_done),
    .out_bytes(out_bytes)
);

assign FSM_state = fsm FSM.state;
assign FSM_done = fsm.FSM.done;
assign out_bytes = datapath.out_bytes;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
