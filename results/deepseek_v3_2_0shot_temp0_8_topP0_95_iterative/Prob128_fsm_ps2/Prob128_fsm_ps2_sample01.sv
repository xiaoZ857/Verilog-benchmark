
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  reg [1:0] state;
  localparam WAIT_BYTE1 = 2'd0;
  localparam WAIT_BYTE2 = 2'd1;
  localparam WAIT_BYTE3 = 2'd2;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= WAIT_BYTE1;
      done <= 1'b0;
    end else begin
      done <= 1'b0;  // Default value
      case (state)
        WAIT_BYTE1: begin
          if (in[3] == 1'b1) begin
            state <= WAIT_BYTE2;
          end
          // Otherwise stay in WAIT_BYTE1
        end
        WAIT_BYTE2: begin
          // Accept any byte as byte 2
          state <= WAIT_BYTE3;
        end
        WAIT_BYTE3: begin
          // Accept any byte as byte 3
          state <= WAIT_BYTE1;
          done <= 1'b1;  // Signal done after third byte
        end
        default: begin
          state <= WAIT_BYTE1;
        end
      endcase
    end
  end
endmodule
