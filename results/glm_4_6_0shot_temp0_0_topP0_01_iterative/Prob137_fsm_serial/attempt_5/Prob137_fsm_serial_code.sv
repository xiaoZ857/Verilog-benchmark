
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);

always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    bit_count <= 4'd0;
    done <= 1'b0;
  end else begin
    case (state)
      IDLE: begin
        done <= 1'b0;
        if (in == 1'b0) begin  // Start bit detected
          state <= START;
          bit_count <= 4'd0;
        end
      end
      
      START: begin
        // Verify start bit is still 0 (sample it)
        if (in == 1'b0) begin
          state <= DATA;
          bit_count <= 4'd0;
        end else begin
          // False start, go back to idle
          state <= IDLE;
        end
      end
      
      DATA: begin
        bit_count <= bit_count + 1'b1;
        if (bit_count == 4'd7) begin
          // After 8 data bits, check for stop bit
          state <= STOP;
        end
      end
      
      STOP: begin
        if (in == 1'b1) begin  // Correct stop bit
          state <= IDLE;
          done <= 1'b1;
        end else begin  // Incorrect stop bit
          state <= WAIT_STOP;
        end
      end
      
      WAIT_STOP: begin
        if (in == 1'b1) begin  // Found stop bit
          state <= IDLE;
        end
      end
      
      default: begin
        state <= IDLE;
      end
    endcase
  end
end

endmodule
