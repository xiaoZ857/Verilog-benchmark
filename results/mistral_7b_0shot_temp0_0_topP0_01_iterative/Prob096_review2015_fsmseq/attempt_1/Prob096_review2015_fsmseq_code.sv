
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output reg start_shifting
);

reg state; // Current state of the FSM
reg sequence_counter; // Counter for the current sequence position

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0; // Reset the FSM to the initial state
    start_shifting <= 0; // Reset start_shifting
  end else if (state == 0) begin
    sequence_counter <= 1'b0; // Start searching from the first bit
    state <= 1; // Move to the next state
  end else if (sequence_counter < 3) begin
    if (data == sequence_counter) begin
      sequence_counter <= sequence_counter + 1;
    end else begin
      sequence_counter <= 1'b0; // Reset the counter and stay in the same state
    end
  end else begin
    if (data == 1'b1 && sequence_counter == 3) begin
      start_shifting <= 1; // Found the sequence, set start_shifting to 1
      state <= 2; // Move to the next state
    end else begin
      sequence_counter <= 1'b0; // Reset the counter and stay in the same state
    end
  end
end

// The FSM has three states:
//  0: Idle, waiting for the first bit of a potential sequence
//  1: Searching for the second bit (1) of the sequence
//  2: Searching for the third bit (1) of the sequence or checking if found the sequence (110)

endmodule

// VERILOG-EVAL: errant inclusion of module definition
