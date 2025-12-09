

module TopModule (
  input clk,
  input in,
  input reset,
  output done
);

reg [7:0] data;
reg start_bit, data_bits, stop_bit, waiting_for_stop;
reg clk_en;

always @(posedge clk) begin
  if (reset) begin
    start_bit <= 0;
    data_bits <= 0;
    stop_bit <= 0;
    waiting_for_stop <= 0;
    clk_en <= 0;
  end else begin
    clk_en <= 1'b1;
    if (start_bit == 0 && in == 1) begin
      start_bit <= 1;
      data_bits <= 0;
    end else if (start_bit == 1 && clk_en) begin
      data_bits <= {data_bits, in};
      if (data_bits >= 8'b10000000) begin
        stop_bit <= in;
        waiting_for_stop <= 0;
      end
    end else if (!waiting_for_stop && stop_bit == 0) begin
      waiting_for_stop <= 1;
    end
  end
end

always @(posedge clk) begin
  if (clk_en) begin
    done <= start_bit && data_bits == 8'b10000000 && stop_bit == 1 && !waiting_for_stop;
  end
endmodule
