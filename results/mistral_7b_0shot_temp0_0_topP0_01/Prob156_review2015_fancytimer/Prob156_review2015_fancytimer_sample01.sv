

module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

reg [3:0] delay = 4'bz; // Initialize delay to all zeros (don't-care)
reg start_sequence_detected = 0;
reg counting = 0;
reg done = 0;
reg remaining_time = 4'bz;

always @(posedge clk) begin
    if (reset) begin
        delay <= 4'bz;
        start_sequence_detected <= 0;
        counting <= 0;
        done <= 0;
    end else if (!counting && data == 4'b1101) begin
        start_sequence_detected <= 1;
        delay = shiftreg(data, 4); // Shift in the next 4 bits to determine the duration of the timer delay
    end else if (start_sequence_detected && counting == 0) begin
        counting <= 1;
        remaining_time = delay;
    end else if (counting) begin
        if (remaining_time > 0) begin
            remaining_time = remaining_time - 1;
        end
        counting <= (remaining_time == 0); // Count until (delay[3:0] + 1) * 1000 clock cycles
    end else if (!counting && ack) begin
        delay <= 4'bz;
        start_sequence_detected <= 0;
        counting <= 0;
        done <= 1;
    end
end

assign count = (counting ? remaining_time : 4'bz); // Assign the current remaining time when counting, otherwise don't-care values

// VERILOG-EVAL: endmodule not found
