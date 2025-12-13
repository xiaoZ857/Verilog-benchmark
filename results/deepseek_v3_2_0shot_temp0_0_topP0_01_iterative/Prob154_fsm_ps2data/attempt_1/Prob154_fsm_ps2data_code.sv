
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
  reg [1:0] state, next_state;
  reg [23:0] msg_reg;
  reg done_reg;
  
  localparam IDLE = 2'b00,
             BYTE2 = 2'b01,
             BYTE3 = 2'b10;
  
  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      IDLE: begin
        if (in[3]) next_state = BYTE2;
        else       next_state = IDLE;
      end
      BYTE2: begin
        next_state = BYTE3;
      end
      BYTE3: begin
        next_state = IDLE;
      end
      default: next_state = IDLE;
    endcase
  end
  
  // Datapath: store bytes
  always @(posedge clk) begin
    if (reset) begin
      msg_reg <= 24'b0;
    end else begin
      case (state)
        IDLE: begin
          if (in[3]) begin
            msg_reg[23:16] <= in; // first byte
          end
        end
        BYTE2: begin
          msg_reg[15:8] <= in;    // second byte
        end
        BYTE3: begin
          msg_reg[7:0] <= in;     // third byte
        end
      endcase
    end
  end
  
  // Done signal: asserted in the cycle after third byte is stored
  always @(posedge clk) begin
    if (reset) begin
      done_reg <= 1'b0;
    end else begin
      done_reg <= (state == BYTE3);
    end
  end
  
  assign done = done_reg;
  assign out_bytes = msg_reg;
endmodule
