
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
reg state; // current state of the FSM
reg start_bit, data_bits[7:0]; // signals for current bit and data bits
reg done_prev = 0; // previous value of done signal

// timescale directive moved outside the module definition
`timescale 1ns / 1ps

always @(posedge clk) begin
  if (reset) begin
    state <= 0; // reset FSM to idle state
    out_byte <= 8'bz; // clear output byte
    done <= 0; // clear done signal
  end else if (state == 0 && in == 0) begin // wait for start bit
    state <= 1;
    start_bit <= in;
  end else if (state == 1) begin // collect data bits
    data_bits[7 - state] <= in;
    state <= state + 1;
    if (state == 8) begin // wait for stop bit
      if (in == 1) begin
        state <= 9; // found stop bit, output data byte and assert done
        out_byte <= data_bits;
        done <= 1;
      end
    end
  end
end

always @(posedge clk) begin
  done <= done_prev; // propagate done signal
  if (state == 9 && in == 0) begin // wait for next start bit after finding a stop bit
    state <= 0;
  end
end

endmodule
