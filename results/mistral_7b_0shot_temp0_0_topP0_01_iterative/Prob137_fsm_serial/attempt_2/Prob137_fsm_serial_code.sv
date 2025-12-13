
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
        if (!start_bit && in) begin // Start bit received
            start_bit <= 1;
            data_bits <= 0;
        end
        else if (start_bit && !in) begin // Start bit lost, wait for next start bit
            start_bit <= 0;
        end
        else if (data_bits < 8 && in) begin // Data bits received
            data[data_bits] <= in;
            data_bits <= data_bits + 1;
        end
        else if (data_bits == 8 && !in && stop_bit != 1) begin // Stop bit expected, but stop bit not received yet
            start_bit <= 0;
            data_bits <= 0;
        end
        else if (data_bits == 8 && in && stop_bit != 1) begin // Data bits and stop bit received out of order
            data[data_bits] <= in;
            data_bits <= data_bits + 1;
        end
        else if (data_bits == 8 && in && stop_bit == 1) begin // Stop bit received correctly
            stop_bit <= in;
            done <= 1;
            data_bits <= 0;
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
