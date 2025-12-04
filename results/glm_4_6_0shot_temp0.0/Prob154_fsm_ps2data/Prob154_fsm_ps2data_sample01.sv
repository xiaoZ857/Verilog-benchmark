
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    byte1 <= 8'h00;
    byte2 <= 8'h00;
    byte3 <= 8'h00;
    done <= 1'b0;
  end else begin
    case (state)
      IDLE: begin
        done <= 1'b0;
        if (in[3]) begin
          byte1 <= in;
          state <= BYTE1;
        end
      end
      
      BYTE1: begin
        byte2 <= in;
        state <= BYTE2;
      end
      
      BYTE2: begin
        byte3 <= in;
        state <= DONE;
      end
      
      DONE: begin
        done <= 1'b1;
        if (in[3]) begin
          byte1 <= in;
          state <= BYTE1;
        end else begin
          state <= IDLE;
        end
      end
    endcase
  end
end

assign out_bytes = {byte1, byte2, byte3};

endmodule
