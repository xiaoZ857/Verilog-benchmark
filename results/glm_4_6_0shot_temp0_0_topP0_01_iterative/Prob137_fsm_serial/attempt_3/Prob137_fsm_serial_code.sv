
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);

reg [2:0] state;
reg [2:0] bit_count;
reg done;

// State encoding
localparam IDLE = 3'd0;
localparam START = 3'd1;
localparam DATA = 3'd2;
localparam STOP = 3'd3;
localparam WAIT_STOP = 3'd4;

always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    bit_count <= 3'd0;
    done <= 1'b0;
  end else begin
    case (state)
      IDLE: begin
        done <= 1'b0;
        if (in == 1'b0) begin  // Start bit detected
          state <= START;
          bit_count <= 3'd0;
        end
      end
      
      START: begin
        state <= DATA;
        bit_count <= 3'd0;
      end
      
      DATA: begin
        if (bit_count == 3'd7) begin
          state <= STOP;
        end
        bit_count <= bit_count + 1'b1;
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
