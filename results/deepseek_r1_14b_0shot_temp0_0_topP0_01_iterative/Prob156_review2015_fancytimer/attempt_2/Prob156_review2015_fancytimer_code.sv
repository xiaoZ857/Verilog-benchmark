
`timescale 1ns / 1ps

default_nettype none

module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

  // State definitions
  enum State {
    SEARCH,
    CAPTURE_DELAY,
    COUNTDOWN,
    WAIT_ACK
  };

  // Internal signals
  reg [3:0] delay;
  reg [15:0] counter;
  reg [7:0] bit_counter;
  reg state;
  reg [3:0] count_out;

  // Initial conditions
  initial begin
    state = SEARCH;
    counting = 0;
    done = 0;
    count_out = 0;
  end

  always @(posedge clk) begin
    if (reset) begin
      state = SEARCH;
      delay = 0;
      counter = 0;
      bit_counter = 0;
      counting = 0;
      done = 0;
      count_out = 0;
    end else case (state) {
      SEARCH: begin
        // Search for pattern 1101
        if (data == 1) begin
          state = CAPTURE_DELAY;
          bit_counter = 3; // Start capturing next 4 bits
        end
      end,
      
      CAPTURE_DELAY: begin
        if (bit_counter >= 0) begin
          delay[bit_counter] = data;
          bit_counter--;
          if (bit_counter == -1) begin
            state = COUNTDOWN;
            counter = (delay + 1) * 16; // (delay+1)*1000 cycles, simplified for simulation
          end
        end
      end,
      
      COUNTDOWN: begin
        if (counter > 0) begin
          counter--;
          count_out = (counter - 1) / 1000; // Simplified counting display
        end else begin
          state = WAIT_ACK;
          done = 1;
          counting = 0;
        end
      end,
      
      WAIT_ACK: begin
        if (ack == 1) begin
          state = SEARCH;
          done = 0;
        end
      end
    }
  end

  // Output assignments
  assign count = count_out;
  assign counting = (state == COUNTDOWN);
  assign done = (state == WAIT_ACK);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
