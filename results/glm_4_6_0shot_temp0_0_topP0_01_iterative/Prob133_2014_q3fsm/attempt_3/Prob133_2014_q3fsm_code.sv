
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg state;
reg [1:0] counter;
reg [1:0] count_ones;

always @(posedge clk) begin
  if (reset) begin
    state <= 1'b0;  // State A
    counter <= 2'b00;
    count_ones <= 2'b00;
    z <= 1'b0;
  end else begin
    case (state)
      1'b0: begin  // State A
        z <= 1'b0;
        if (s) begin
          state <= 1'b1;  // State B
          counter <= 2'b00;
          count_ones <= 2'b00;
        end
      end
      
      1'b1: begin  // State B
        if (counter < 2'b11) begin
          // Counting cycles (0, 1, 2) - accumulate w values
          if (counter == 2'b00) begin
            count_ones <= w;
          end else begin
            count_ones <= count_ones + w;
          end
          counter <= counter + 1;
          z <= 1'b0;
        end else begin
          // Output cycle (counter == 3) - set z based on count
          z <= (count_ones == 2'b10);
          counter <= 2'b00;
          count_ones <= 2'b00;
        end
      end
    endcase
  end
end

endmodule
