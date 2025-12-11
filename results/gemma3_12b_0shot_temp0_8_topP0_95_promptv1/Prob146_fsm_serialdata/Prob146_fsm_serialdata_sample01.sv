
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
logic state;
logic [7:0] data_in;
assign done = state == 3;
assign out_byte = data_in;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    data_in <= 0;
  end else begin
    case (state)
      0: begin
        if (!in) begin
          state <= 1;
        end
      end
      1: begin
        data_in[7:0] <= in;
        if (in == 1) begin
            state <= 2;
        end else begin
            state <= 1;
        end
      end
      2: begin
        data_in[7:0] <= {data_in[6:0], in};
        if (in == 1) begin
          state <= 3;
        end else begin
          state <= 2;
        end
      end
      3: begin
        state <= 0;
      end
      default: state <= 0;
    endcase
  end
endmodule
