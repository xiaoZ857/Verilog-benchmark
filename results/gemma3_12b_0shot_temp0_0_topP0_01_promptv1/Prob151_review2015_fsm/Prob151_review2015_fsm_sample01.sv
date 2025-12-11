
module TopModule (
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);
always @(posedge clk) begin
  if (reset) begin
    shift_ena <= 1'b0;
    counting <= 1'b0;
    done <= 1'b0;
  end else begin
    if (ack) begin
      shift_ena <= 1'b0;
      counting <= 1'b0;
      done <= 1'b0;
    end else if (done) begin
      shift_ena <= 1'b0;
      counting <= 1'b0;
      done <= 1'b0;
    end else if (counting) begin
      if (done_counting) begin
        done <= 1'b1;
      end else begin
        counting <= 1'b1;
        done <= 1'b0;
      end
    end else if (shift_ena) begin
      shift_ena <= 1'b0;
    end else begin
      if (data == 1'b1) begin
        if (shift_ena == 1'b0) begin
          shift_ena <= 1'b1;
        end
      end else begin
        shift_ena <= 1'b0;
      end
    end
  end
endmodule
