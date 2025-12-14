
module TopModule (
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);

reg state;
reg [3:0] shift_shifted_data;

always @(posedge clk) begin
  if (reset)
    state <= 0; // Reset to state 'start'
  else if (data && data[2] == 1 && data[1] == 1 && data[0] == 1 && data[3] == 1)
    shift_shifted_data <= {data[2:], data[1], data[0], 0}; // Shift and store the pattern
  else if (shift_shifted_data != 4'b0000) // Shift enabled, count down
    counting <= ~state;
  else if (~done_counting && ack == 0)
    state <= 5; // Notified but not acknowledged, wait for acknowledgement
  else if (done_counting & ack)
    done <= 1; // Timer timed out, acknowledge and reset
  else
    state <= 4; // Reset to state 'start', looking for the pattern again
end

always @(state) begin
  case(state)
    0: shift_ena <= 0;
    1: shift_ena <= ~state == 2 || data == 4'b1101;
    2: shift_ena <= 1;
    3: counting <= 1;
    4: done <= 1;
    default: 
      if (~data && state > 0)
        state <= state - 1; // Backtrack
      else
        state <= 0; // Pattern not found, reset and start again
  endcase
end

always @(state) begin
  if (state >= 2 && state < 6) // Counting and waiting for pattern
    shift_shifted_data <= {shift_shifted_data[3:1], data[0]}; // Shift the input bit
end

assign counting = ~state;
assign done = done & ack;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
