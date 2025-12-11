
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
logic [23:0] message_bytes;
logic [2:0] state;
logic byte_count;
logic done_internal;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    byte_count <= 0;
    done_internal <= 0;
  end else begin
    case (state)
      0: begin
        if (in[3] == 1) begin
          state <= 1;
          byte_count <= 0;
        end else begin
          state <= 0;
          byte_count <= 0;
        end
      end
      1: begin
        byte_count <= byte_count + 1;
        if (byte_count == 1) begin
          message_bytes[23:16] <= in;
        end else if (byte_count == 2) begin
          message_bytes[15:8] <= in;
        end else if (byte_count == 3) begin
          message_bytes[7:0] <= in;
          state <= 0;
          done_internal <= 1;
        end else begin
          state <= 0;
          done_internal <= 0;
        end
      end
      default: begin
        state <= 0;
        done_internal <= 0;
      end
    endcase
  end
end

assign out_bytes = message_bytes;
assign done = done_internal;
endmodule
