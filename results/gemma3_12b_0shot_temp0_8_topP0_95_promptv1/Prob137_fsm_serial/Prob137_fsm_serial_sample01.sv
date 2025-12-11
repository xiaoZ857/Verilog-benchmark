
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
logic state;
logic bit_count;
logic stop_bit_expected;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    bit_count <= 0;
    stop_bit_expected <= 0;
    done <= 0;
  end else begin
    case (state)
      0: begin // Idle state
        if (in == 0) begin
          state <= 1;
          stop_bit_expected <= 0;
        end
      end
      1: begin // Start bit detected
        if (bit_count == 0) begin
          state <= 2;
          bit_count <= 1;
        end else if (bit_count == 1) begin
          state <= 2;
          bit_count <= 2;
        end else if (bit_count == 8) begin
          state <= 3;
          bit_count <= 2;
        end
        else if (bit_count < 8) begin
          bit_count <= bit_count + 1;
        end
      end
      2: begin
          if (bit_count == 8) begin
              state <= 3;
              bit_count <= 2;
          end else if (bit_count < 8) begin
              bit_count <= bit_count + 1;
          end
      end
      3: begin // Stop bit expected
        if (in == 1) begin
          state <= 0;
          done <= 1;
          bit_count <= 0;
        end else begin
            state <= 3;
        end
      end
    endcase
  end
end

assign done = (state == 0 && bit_count == 0);
endmodule
