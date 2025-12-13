
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
always @(posedge clk) begin
    if (reset) begin
        start_bit <= 0;
        data_bits <= 0;
        stop_bit <= 0;
        data <= 8'b0;
        done <= 0;
    end else begin
        // Check for the start bit
        if (!start_bit && in) begin
            start_bit <= 1;
            data_bits <= 0;
        end

        // If the start bit is detected, start receiving data bits
        if (start_bit) begin
            // Receive data bits
            if (data_bits < 8 && in) begin
                data[data_bits] <= in;
                data_bits <= data_bits + 1;
            end

            // Check for the stop bit after all data bits have been received
            if (data_bits == 8 && !in && stop_bit != 1) begin
                start_bit <= 0;
                data_bits <= 0;
            end

            // If the stop bit is detected, set done and reset state variables
            if (data_bits == 8 && in && stop_bit == 1) begin
                stop_bit <= in;
                done <= 1;
                start_bit <= 0;
                data_bits <= 0;
            end
        end
    end
end

// Add a clock enable for the output to prevent glitches
always @(posedge clk) begin
    if (!reset) begin
        qdone <= done;
    end
end

// VERILOG-EVAL: endmodule not found
