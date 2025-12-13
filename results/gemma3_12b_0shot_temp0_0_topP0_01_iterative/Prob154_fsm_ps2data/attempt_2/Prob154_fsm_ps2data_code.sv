
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
  reg [23:0] out_bytes_reg;
  reg [2:0] state;
  reg done_reg;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      done_reg <= 0;
      out_bytes_reg <= 0;
    end else begin
      case (state)
        0: begin // Initial state - searching for byte 1
          if (in[3] == 1) begin
            state <= 1;
            out_bytes_reg <= in;
          end else begin
            state <= 0;
            out_bytes_reg <= 0;
          end
        end
        1: begin // Received byte 1 - searching for byte 2
          out_bytes_reg <= {out_bytes_reg[15:0], in};
          state <= 2;
        end
        2: begin // Received byte 1 and 2 - searching for byte 3
          out_bytes_reg <= {out_bytes_reg[15:0], in};
          state <= 3;
        end
        3: begin // Received all 3 bytes - done
          done_reg <= 1;
          state <= 0;
        end
        default: begin
          state <= 0;
          done_reg <= 0;
          out_bytes_reg <= 0;
        end
      endcase
    end
  end

  assign out_bytes = out_bytes_reg;
  assign done = done_reg;

// VERILOG-EVAL: endmodule not found
