
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  always @(posedge clk) begin
    if (reset) begin
      done <= 1'b0;
    end else begin
      done <= 1'b0;
      case (state)
        WAIT_BYTE1: begin
          if (in[3] == 1'b1) begin
            state <= WAIT_BYTE2;
          end
        end
        WAIT_BYTE2: begin
          state <= WAIT_BYTE3;
        end
        WAIT_BYTE3: begin
          state <= WAIT_BYTE1;
          done <= 1'b1;
        end
        default: begin
          state <= WAIT_BYTE1;
        end
      endcase
    end
  end
endmodule
