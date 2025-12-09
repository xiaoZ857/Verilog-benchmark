
module TopModule (
  input wire clk,
  input wire reset,
  input wire in,
  output reg done
);

reg [7:0] data; // 8-bit register to store received data
reg start_bit, data_bits, stop_bit; // flags for current state

always @(posedge clk) begin
    if (reset) begin
        start_bit <= 0;
        data_bits <= 0;
        stop_bit <= 0;
    end else if (!start_bit && in) begin
        start_bit <= 1; // start bit received, enter data receiving state
    end else if (data_bits < 8) begin
        data[data_bits] <= in; // store incoming data bit
        data_bits <= data_bits + 1;
    end else if (!stop_bit && !in) begin
        stop_bit <= 1; // no data bit received, expect stop bit
    end else if (stop_bit && in) begin
        done <= 1; // byte correctly received, assert done
        start_bit <= 0;
        data_bits <= 0;
        stop_bit <= 0;
    end
end

assign done = !reset && done; // ensure done is only asserted after reset deassertion

endmodule

// VERILOG-EVAL: errant inclusion of module definition
