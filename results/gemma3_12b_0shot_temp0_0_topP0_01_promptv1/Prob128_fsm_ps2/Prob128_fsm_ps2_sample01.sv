
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
logic state;
logic [7:0] byte_buffer;
assign done = state == 2;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
  end else begin
    case (state)
      1: begin
        byte_buffer <= in;
        state <= 2;
      end
      2: begin
        if (in[3] == 1) begin
          state <= 1;
        end else begin
          state <= 2;
        end
      end
      default: begin
        state <= 0;
      end
    endcase
  end
endmodule
