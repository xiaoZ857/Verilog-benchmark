
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

reg [3:0] state, next_state;
reg [2:0] bit_count;
reg [7:0] data_shift;
reg done_reg;

parameter IDLE = 4'd0;
parameter START = 4'd1;
parameter DATA = 4'd2;
parameter STOP = 4'd3;
parameter WAIT_STOP = 4'd4;

always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    bit_count <= 3'd0;
    data_shift <= 8'd0;
    done_reg <= 1'b0;
  end else begin
    state <= next_state;
    done_reg <= 1'b0;
    
    case (state)
      START: begin
        bit_count <= 3'd0;
        data_shift <= 8'd0;
      end
      DATA: begin
        bit_count <= bit_count + 1;
        data_shift <= {in, data_shift[7:1]};
      end
      STOP: begin
        if (in == 1'b1) begin
          done_reg <= 1'b1;
        end
      end
      WAIT_STOP: begin
        if (in == 1'b1) begin
          done_reg <= 1'b1;
        end
      end
    endcase
  end
end

always @(*) begin
  next_state = state;
  
  case (state)
    IDLE: begin
      if (in == 1'b0) begin
        next_state = START;
      end
    end
    START: begin
      next_state = DATA;
    end
    DATA: begin
      if (bit_count == 3'd7) begin
        next_state = STOP;
      end
    end
    STOP: begin
      if (in == 1'b1) begin
        next_state = IDLE;
      end else begin
        next_state = WAIT_STOP;
      end
    end
    WAIT_STOP: begin
      if (in == 1'b1) begin
        next_state = IDLE;
      end
    end
  endcase

// VERILOG-EVAL: endmodule not found
