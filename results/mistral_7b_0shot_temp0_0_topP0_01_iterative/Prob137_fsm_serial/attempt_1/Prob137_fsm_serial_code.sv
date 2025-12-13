
module TopModule (
  input wire clk,
  input wire reset,
  input wire in,
  output reg done
);

reg [7:0] data; // 8-bit data register
reg start_bit, data_bits, stop_bit; // flags for current state

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
        else if (data_bits == 8 && !in) begin // Stop bit expected, but stop bit not received yet
            start_bit <= 0;
            data_bits <= 0;
        end
        else if (data_bits == 8 && in && stop_bit != 1) begin // Stop bit received
            stop_bit <= in;
            if (stop_bit == 1) begin
                done <= 1;
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

output reg qdone; // Clock-enabled output

endmodule

// VERILOG-EVAL: errant inclusion of module definition
