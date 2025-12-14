
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
reg state; // FSM state register
reg sequence[3]; // Sequence buffer for 1101
reg lastData; // Last input data
reg currentIndex; // Current position in sequence

always @(posedge clk) begin
    if (reset)
        begin
            state <= 0;
            start_shifting <= 0;
        end
    else if (state == 0 && data == 1)
        state <= 1; // Start of sequence, set state to 1
    else if (state == 1 && data == 1)
        sequence[currentIndex] <= data; // Buffer input data
    else if (state == 2 && data == 0)
        begin
            currentIndex <= currentIndex + 1; // Increment index, check for complete sequence
            if (currentIndex == 3) // If we checked the entire sequence buffer
                begin
                    always_comb begin
                        start_shifting <= 1'b1; // Set start_shifting to 1
                    end
                    state <= 4; // Go to idle state after finding the sequence
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
    if (state == 4)
        start_shifting <= 1'b1;
    else
        start_shifting <= 1'b0;
end

// VERILOG-EVAL: abnormal backticks count
