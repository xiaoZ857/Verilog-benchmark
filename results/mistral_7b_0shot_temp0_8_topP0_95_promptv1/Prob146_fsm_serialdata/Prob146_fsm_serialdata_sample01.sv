
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
 ```verilog
reg [7:0] data_reg;
logic start_bit_detected, stop_bit_detected, byte_received;
always @(posedge clk) begin
    if (reset) begin
        start_bit_detected <= 0;
        stop_bit_detected <= 0;
        data_reg <= 8'bz;
        byte_received <= 0;
    end else begin
        if (!start_bit_detected && in) begin
            start_bit_detected <= 1;
            data_reg[0] <= in;
        end else if (start_bit_detected && !in) begin
            data_reg <<= 1;
            data_reg[7] <= in;
        end else if (start_bit_detected && in) begin
            data_reg <<= 1;
        end else if (!stop_bit_detected && in) begin
            if (byte_received) begin
                out_byte <= data_reg;
            end
            data_reg <<= 1;
            data_reg[7] <= in;
            if (data_reg == 8'b1 || data_reg == 8'b0)
                stop_bit_detected <= 1;
        end
    end
end

always @(posedge clk) begin
    if (!reset && start_bit_detected && data_reg != 8'bz && !stop_bit_detected)
        byte_received <= 1;
end

assign done = stop_bit_detected;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
