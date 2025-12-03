

module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [2:0] state;
  reg [7:0] byte_buffer [3:0];
  reg [23:0] out_bytes_r;
  reg done_r;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      out_bytes_r <= 0;
      done_r <= 0;
    end else begin
      case (state)
        0: begin
          if (in[3] == 1) begin
            state <= 1;
            byte_buffer[0] <= in;
          end else begin
            state <= 0;
          end
        end
        1: begin
          byte_buffer[1] <= in;
          state <= 2;
        end
        2: begin
          byte_buffer[2] <= in;
          state <= 3;
        end
        3: begin
          byte_buffer[3] <= in;
          state <= 0;
          done_r <= 1;
        end
        default: begin
          state <= 0;
        end
      endcase
    end
  end

  assign out_bytes = out_bytes_r;
  assign done = done_r;

  always @(posedge clk) begin
    if (reset) begin
      out_bytes_r <= 0;
    end else if (done_r) begin
      out_bytes_r <= {byte_buffer[0], byte_buffer[1], byte_buffer[2], byte_buffer[3]};
    end
  end
endmodule
