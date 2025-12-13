
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

reg state = 0; // Initial state is waiting for start sequence
reg counter_value = 3'b000; // Counter value when shift_ena is asserted
reg done_flag = 0; // Flag to indicate if counters have finished counting

always @(posedge clk) begin
  if (reset) begin
    state <= 0; // Reset to initial state
    counter_value <= 3'b000;
    done_flag <= 0;
  end

  case (state)
    0: begin // Waiting for start sequence
      if (data == 4'b1101) begin
        state <= 1; // Start sequence detected, shift in 4 bits and assert shift_ena
        counter_value <= data;
        shift_ena <= 1;
      end
    end
    1: begin // Shifting in 4 bits and waiting for done_counting to be high
      if (counter_value >= 4'b1101) begin
        state <= 2; // Counters finished counting, wait for done_counting
        counting <= 1;
      end else begin
        counter_value <= {data, counter_value[1:0]}; // Shift in new data
      end
    end
    2: begin // Waiting for done_counting to be high
      if (done_counting) begin
        state <= 3; // Done counting, assert done and wait for ack
        done <= 1;
      end
    end
    3: begin // Waiting for ack
      if (ack) begin
        state <= 0; // Acknowledged, reset to initial state
        done_flag <= 1;
      end
    end
  endcase
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
