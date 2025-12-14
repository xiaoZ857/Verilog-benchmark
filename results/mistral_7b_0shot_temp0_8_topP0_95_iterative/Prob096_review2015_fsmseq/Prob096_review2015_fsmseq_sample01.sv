
reg state; // FSM state register
reg sequence[3]; // Sequence buffer for 1101
reg lastData; // Last input data
reg currentIndex; // Current position in sequence
reg start_shifting; // Output signal to be set when the sequence is found

always @(posedge clk) begin
    if (reset)
        state <= 0;
    else if (state == 0 && data == 1)
        state <= 1; // Start of sequence, set state to 1
    else if (state == 1 && data == 1)
        sequence[currentIndex] <= data; // Buffer input data
    else if (state == 2 && data == 0)
        begin
            currentIndex <= currentIndex + 1; // Increment index, check for complete sequence
            if (currentIndex == 3) // If we checked the entire sequence buffer
                begin
                    state <= 4; // Go to idle state after finding the sequence
                    start_shifting <= 1'b1; // Set start_shifting to 1 when sequence found
                end
        end
    else if (state == 4 && data != lastData) // If the input changed while in idle state, reset sequence buffer
        begin
            currentIndex <= 0;
            state <= 1; // Reset sequence buffer and go to searching state again
        end
    lastData <= data; // Update lastData regardless of state
end

always @(posedge clk) begin
    start_shifting = (state == 4); // Ensure that start_shifting is always positive clock triggered
end

// Ensure `timescale` directive is placed outside any module definitions
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
